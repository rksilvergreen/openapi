import 'dart:io';

import 'package:yaml/yaml.dart';

import '../../validation_exception.dart';
import 'src/reference_collector.dart';
import 'src/reference_finder.dart';
import 'src/semantic_schema_validator.dart';
import 'src/semantic_paths_validator.dart';

export '../../validation_exception.dart';

/// Semantic validator for OpenAPI specifications (Stage 3).
///
/// This validator performs post-parsing semantic checks to ensure:
/// - Logical consistency and coherence
/// - Reference resolution and existence
/// - Composition semantics (allOf, oneOf, anyOf)
/// - Discriminator logic and property existence
/// - Cross-schema consistency
/// - Meaningful modeling practices
///
/// Structural validation (vocabulary and structure) is performed in Stage 1.
abstract class SemanticValidator {
  /// Validates the semantic correctness of an OpenAPI document.
  ///
  /// This performs Stage 3 (Semantic Validation) only.
  /// Expects the document to already be structurally valid.
  ///
  /// [document] is the parsed and structurally-validated YAML document.
  /// [baseDirectory] is used to resolve external file references.
  ///
  /// Throws [OpenApiValidationException] if semantic validation fails.
  static void validate(Map<dynamic, dynamic> document, {String? baseDirectory}) {
    try {
      // First pass: validate references
      final collector = ReferenceCollector(baseDirectory: baseDirectory);
      ReferenceFinder.findReferences(document, '', collector);

      final referenceErrors = collector.validateReferences(document);
      if (referenceErrors.isNotEmpty) {
        throw OpenApiValidationException(
          '/',
          'Invalid references found:\n${referenceErrors.join('\n')}',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }

      // Second pass: validate external file contents
      _validateExternalFiles(collector, baseDirectory);

      // Third pass: validate semantic rules
      _validateSemanticRules(document);
    } catch (e) {
      if (e is OpenApiValidationException) {
        rethrow;
      }
      throw OpenApiValidationException(
        '/',
        'Unexpected error during semantic validation: $e',
        specReference: 'OpenAPI 3.0.0',
      );
    }
  }

  /// Validates the contents of external files that are referenced.
  static void _validateExternalFiles(ReferenceCollector collector, String? baseDirectory) {
    final validatedRefs = <String>{};

    for (final entry in collector.externalReferences.entries) {
      final ref = entry.key;
      final paths = entry.value;

      _validateExternalReference(ref, paths.first, baseDirectory, validatedRefs);
    }
  }

  /// Recursively validates a single external reference and all references it contains.
  static void _validateExternalReference(
    String ref,
    String referencingPath,
    String? baseDirectory,
    Set<String> validatedRefs,
  ) {
    if (validatedRefs.contains(ref)) {
      return;
    }
    validatedRefs.add(ref);

    final refParts = ref.split('#');
    final filePath = refParts[0];
    final fragment = refParts.length > 1 ? refParts[1] : null;

    String resolvedPath = filePath;
    if (baseDirectory != null) {
      resolvedPath = '$baseDirectory/$filePath';
    }

    try {
      final file = File(resolvedPath);
      final fileContent = file.readAsStringSync();
      final externalDoc = loadYaml(fileContent);

      if (externalDoc is! Map) {
        throw OpenApiValidationException(
          referencingPath,
          'External file "$filePath" must contain a valid object',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }

      Map<dynamic, dynamic> targetObject;
      String targetPath;

      if (fragment != null && fragment.isNotEmpty) {
        targetObject = _navigateToFragment(externalDoc, fragment, filePath);
        targetPath = '$filePath#$fragment';
      } else {
        targetObject = externalDoc;
        targetPath = filePath;
      }

      // Validate the target object semantically
      // (Structural validation would have been done in Stage 1)

      // RECURSIVE STEP: Find and validate references within the target object
      final externalCollector = ReferenceCollector(baseDirectory: baseDirectory);
      ReferenceFinder.findReferences(targetObject, targetPath, externalCollector);

      final docToValidateAgainst = fragment != null ? externalDoc : targetObject;
      final referenceErrors = externalCollector.validateReferences(docToValidateAgainst);
      if (referenceErrors.isNotEmpty) {
        throw OpenApiValidationException(
          referencingPath,
          'External reference "$ref" has invalid references:\n${referenceErrors.join('\n')}',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }

      for (final entry in externalCollector.externalReferences.entries) {
        final nestedRef = entry.key;
        _validateExternalReference(nestedRef, '$ref (referenced from $referencingPath)', baseDirectory, validatedRefs);
      }
    } on YamlException catch (e) {
      throw OpenApiValidationException(
        referencingPath,
        'External file "$filePath" contains invalid YAML: ${e.message}',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
      );
    } on FileSystemException catch (e) {
      throw OpenApiValidationException(
        referencingPath,
        'Failed to read external file "$filePath": ${e.message}',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
      );
    }
  }

  static Map<dynamic, dynamic> _navigateToFragment(Map<dynamic, dynamic> document, String fragment, String filePath) {
    final pointer = fragment.startsWith('/') ? fragment.substring(1) : fragment;

    if (pointer.isEmpty) {
      return document;
    }

    final parts = pointer.split('/');
    dynamic current = document;

    for (var i = 0; i < parts.length; i++) {
      var part = parts[i];
      part = Uri.decodeComponent(part.replaceAll('~1', '/').replaceAll('~0', '~'));

      if (current is Map) {
        if (!current.containsKey(part)) {
          throw OpenApiValidationException(
            filePath,
            'Fragment path "/$pointer" not found in external file "$filePath" at segment "$part"',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
          );
        }
        current = current[part];
      } else if (current is List) {
        final index = int.tryParse(part);
        if (index == null || index < 0 || index >= current.length) {
          throw OpenApiValidationException(
            filePath,
            'Fragment path "/$pointer" invalid in external file "$filePath" at segment "$part"',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
          );
        }
        current = current[index];
      } else {
        throw OpenApiValidationException(
          filePath,
          'Fragment path "/$pointer" cannot traverse non-object/non-array at segment "$part"',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }
    }

    if (current is! Map) {
      throw OpenApiValidationException(
        filePath,
        'Fragment path "/$pointer" must point to an object',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
      );
    }

    return current;
  }

  /// Validates semantic rules across the document
  static void _validateSemanticRules(Map<dynamic, dynamic> document) {
    // Validate schema semantic rules (composition, discriminator, etc.)
    if (document.containsKey('components')) {
      final components = document['components'];
      if (components is Map && components.containsKey('schemas')) {
        final schemas = components['schemas'];
        if (schemas is Map) {
          for (final entry in schemas.entries) {
            final schemaName = entry.key.toString();
            final schema = entry.value;
            if (schema is Map) {
              SemanticSchemaValidator.validate(schema, 'components/schemas.$schemaName', document: document);
            }
          }
        }
      }
    }

    // Validate paths semantic rules (duplicate templated paths, etc.)
    if (document.containsKey('paths')) {
      final paths = document['paths'];
      if (paths is Map) {
        SemanticPathsValidator.validate(paths, 'paths');
      }
    }
  }
}

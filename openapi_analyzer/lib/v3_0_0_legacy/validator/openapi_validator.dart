import 'dart:io';

import 'package:yaml/yaml.dart';

import 'src/validation_exception.dart';
import 'src/reference_collector.dart';
import 'src/reference_finder.dart';
import 'src/openapi_object_validator.dart';
import 'src/schema_object_validator.dart';

export 'src/validation_exception.dart';

/// Main validator for OpenAPI specifications.
abstract class OpenApiValidator {

  /// Validates an OpenAPI YAML content string.
  ///
  /// Returns the parsed YAML document as a Map.
  ///
  /// Throws [OpenApiValidationException] if validation fails.
  /// Throws [FormatException] if YAML parsing fails.
  ///
  /// [baseDirectory] is used to resolve external file references.
  static Map<dynamic, dynamic> validate(String yamlContent, {String? baseDirectory}) {
    try {
      // Parse YAML
      final yamlDoc = loadYaml(yamlContent);

      // Ensure root is a Map
      if (yamlDoc is! Map) {
        throw OpenApiValidationException(
          '/',
          'OpenAPI document root must be an object',
          specReference: 'OpenAPI 3.0.0 - Document Structure',
        );
      }

      // Check for openapi field to determine version
      final rootMap = yamlDoc;
      if (!rootMap.containsKey('openapi')) {
        throw OpenApiValidationException(
          '/',
          'OpenAPI document must have an "openapi" field',
          specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
        );
      }

      final openapiVersion = rootMap['openapi']?.toString();
      if (openapiVersion == null || openapiVersion.isEmpty) {
        throw OpenApiValidationException(
          '/openapi',
          'openapi field cannot be empty',
          specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
        );
      }

      // For now, only support 3.0.0
      if (openapiVersion == '3.0.0') {
        // First pass: validate structure
        OpenApiObjectValidator.validate(rootMap, '');

        // Second pass: validate references
        final collector = ReferenceCollector(baseDirectory: baseDirectory);
        ReferenceFinder.findReferences(rootMap, '', collector);

        final referenceErrors = collector.validateReferences(rootMap);
        if (referenceErrors.isNotEmpty) {
          throw OpenApiValidationException(
            '/',
            'Invalid references found:\n${referenceErrors.join('\n')}',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
          );
        }

        // Third pass: validate external file contents
        _validateExternalFiles(collector, baseDirectory);
      } else {
        throw OpenApiValidationException(
          '/openapi',
          'Unsupported OpenAPI version: $openapiVersion. Only 3.0.0 is currently supported',
          specReference: 'OpenAPI 3.0.0 - Versions',
        );
      }

      return rootMap;
    } on YamlException catch (e) {
      throw FormatException('Failed to parse YAML: ${e.message}', e.span?.start.offset);
    } on OpenApiValidationException {
      // Re-throw validation exceptions
      rethrow;
    } catch (e) {
      if (e is OpenApiValidationException) {
        rethrow;
      }
      throw OpenApiValidationException('/', 'Unexpected error during validation: $e', specReference: 'OpenAPI 3.0.0');
    }
  }

  /// Validates the contents of external files that are referenced.
  /// This is recursive - external files that reference other external files
  /// will have those files validated as well.
  static void _validateExternalFiles(ReferenceCollector collector, String? baseDirectory) {
    final validatedRefs = <String>{}; // Track already validated refs to avoid duplicates and infinite loops

    for (final entry in collector.externalReferences.entries) {
      final ref = entry.key;
      final paths = entry.value;

      // Recursively validate this external reference and all its dependencies
      _validateExternalReference(ref, paths.first, baseDirectory, validatedRefs);
    }
  }

  /// Recursively validates a single external reference and all references it contains.
  /// Handles both whole-file references (file.yaml) and fragment references (file.yaml#/path/to/item).
  static void _validateExternalReference(
    String ref,
    String referencingPath,
    String? baseDirectory,
    Set<String> validatedRefs,
  ) {
    // Skip if already validated (prevents infinite loops)
    if (validatedRefs.contains(ref)) {
      return;
    }
    validatedRefs.add(ref);

    // Parse reference: split into file path and optional fragment
    final refParts = ref.split('#');
    final filePath = refParts[0];
    final fragment = refParts.length > 1 ? refParts[1] : null;

    // Resolve file path
    String resolvedPath = filePath;
    if (baseDirectory != null) {
      resolvedPath = '$baseDirectory/$filePath';
    }

    // Load and validate the external file
    try {
      final file = File(resolvedPath);
      final fileContent = file.readAsStringSync();
      final externalDoc = loadYaml(fileContent);

      // Ensure external document is a Map
      if (externalDoc is! Map) {
        throw OpenApiValidationException(
          referencingPath,
          'External file "$filePath" must contain a valid object',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }

      // Determine what to validate based on whether there's a fragment
      Map<dynamic, dynamic> targetObject;
      String targetPath;

      if (fragment != null && fragment.isNotEmpty) {
        // Navigate to the fragment location using JSON Pointer
        targetObject = _navigateToFragment(externalDoc, fragment, filePath);
        targetPath = '$filePath#$fragment';
      } else {
        // No fragment - validate the entire document as a Schema Object
        targetObject = externalDoc;
        targetPath = filePath;
      }

      // Validate as Schema Object (most common case)
      // Note: In the future, we could determine the expected type based on the reference context
      try {
        SchemaObjectValidator.validate(targetObject, targetPath);
      } catch (e) {
        if (e is OpenApiValidationException) {
          throw OpenApiValidationException(
            referencingPath,
            'External reference "$ref" validation failed: ${e.message}',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
          );
        }
        rethrow;
      }

      // RECURSIVE STEP: Find and validate references within the target object
      final externalCollector = ReferenceCollector(baseDirectory: baseDirectory);
      ReferenceFinder.findReferences(targetObject, targetPath, externalCollector);

      // Validate that internal references within the external object exist
      // For fragments, we need to validate against the whole document, not just the fragment
      final docToValidateAgainst = fragment != null ? externalDoc : targetObject;
      final referenceErrors = externalCollector.validateReferences(docToValidateAgainst);
      if (referenceErrors.isNotEmpty) {
        throw OpenApiValidationException(
          referencingPath,
          'External reference "$ref" has invalid references:\n${referenceErrors.join('\n')}',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }

      // Recursively validate any external files referenced by this object
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

  /// Navigates to a specific location in a document using a JSON Pointer fragment.
  /// The fragment should NOT include the leading '#' or '/'.
  static Map<dynamic, dynamic> _navigateToFragment(Map<dynamic, dynamic> document, String fragment, String filePath) {
    // Remove leading '/' if present
    final pointer = fragment.startsWith('/') ? fragment.substring(1) : fragment;

    if (pointer.isEmpty) {
      return document;
    }

    final parts = pointer.split('/');
    dynamic current = document;

    for (var i = 0; i < parts.length; i++) {
      var part = parts[i];

      // Decode JSON Pointer escaping
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
            'Fragment path "/$pointer" invalid in external file "$filePath" at segment "$part" (expected valid array index)',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
          );
        }
        current = current[index];
      } else {
        throw OpenApiValidationException(
          filePath,
          'Fragment path "/$pointer" cannot traverse non-object/non-array at segment "$part" in external file "$filePath"',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }
    }

    if (current is! Map) {
      throw OpenApiValidationException(
        filePath,
        'Fragment path "/$pointer" in external file "$filePath" must point to an object, got ${current.runtimeType}',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
      );
    }

    return current;
  }
}

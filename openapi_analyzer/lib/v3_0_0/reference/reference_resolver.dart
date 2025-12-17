import 'dart:io';
import 'package:yaml/yaml.dart';
import '../../validation_exception.dart';
import '../validation/validation_context.dart';
import '../models/openapi_graph.dart';

/// Handles resolution of $ref references in OpenAPI documents.
///
/// Supports both internal references (#/components/schemas/User) and
/// external references (common.yaml#/definitions/Base).
class ReferenceResolver {
  final File baseFile;
  final ValidationContext validationContext;
  final Map<String, Map<dynamic, dynamic>> _loadedDocuments = {};

  ReferenceResolver(this.baseFile, this.validationContext) {
    // Cache the base document
    _loadedDocuments[baseFile.path] = {};
  }

  /// Parses a $ref string into its components.
  ///
  /// Returns a [ResolvedReference] with document path and JSON pointer.
  ResolvedReference parseReference(String ref, String currentPath) {
    if (ref.startsWith('#')) {
      // Internal reference
      return ResolvedReference(
        documentPath: baseFile.path,
        jsonPointer: ref.substring(1), // Remove leading #
        isExternal: false,
      );
    } else if (ref.contains('#')) {
      // External reference with fragment
      final parts = ref.split('#');
      final externalPath = _resolveExternalPath(parts[0]);
      return ResolvedReference(
        documentPath: externalPath,
        jsonPointer: parts.length > 1 ? parts[1] : '/',
        isExternal: true,
      );
    } else {
      // External reference without fragment (references whole document)
      final externalPath = _resolveExternalPath(ref);
      return ResolvedReference(documentPath: externalPath, jsonPointer: '/', isExternal: true);
    }
  }

  /// Resolves a relative external file path to an absolute path.
  String _resolveExternalPath(String relativePath) {
    final baseDir = baseFile.parent;
    final externalFile = File('${baseDir.path}/$relativePath');
    return externalFile.path;
  }

  /// Loads an external document if not already cached.
  ///
  /// Returns the parsed YAML content as a Map.
  Map<dynamic, dynamic> loadExternalDocument(String documentPath) {
    if (_loadedDocuments.containsKey(documentPath)) {
      return _loadedDocuments[documentPath]!;
    }

    final file = File(documentPath);
    if (!file.existsSync()) {
      validationContext.addException(
        OpenApiValidationException(
          '/',
          'External reference file not found: $documentPath',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      return {};
    }

    try {
      final yamlContent = file.readAsStringSync();
      final yamlDoc = loadYaml(yamlContent);

      if (yamlDoc is! Map) {
        validationContext.addException(
          OpenApiValidationException(
            '/',
            'External document must be an object: $documentPath',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
            severity: ValidationSeverity.critical,
          ),
        );
        return {};
      }

      _loadedDocuments[documentPath] = yamlDoc;
      return yamlDoc;
    } catch (e) {
      validationContext.addException(
        OpenApiValidationException(
          '/',
          'Failed to load external document: $documentPath. Error: $e',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      return {};
    }
  }

  /// Resolves a JSON pointer within a document.
  ///
  /// Returns the referenced value or null if not found.
  dynamic resolvePointer(Map<dynamic, dynamic> document, String jsonPointer) {
    if (jsonPointer == '/' || jsonPointer.isEmpty) {
      return document;
    }

    final parts = jsonPointer.split('/').skip(1); // Skip first empty part
    dynamic current = document;

    for (final part in parts) {
      if (current is Map) {
        // Decode JSON pointer special characters
        final decodedPart = part.replaceAll('~1', '/').replaceAll('~0', '~');
        if (!current.containsKey(decodedPart)) {
          return null;
        }
        current = current[decodedPart];
      } else if (current is List) {
        final index = int.tryParse(part);
        if (index == null || index < 0 || index >= current.length) {
          return null;
        }
        current = current[index];
      } else {
        return null;
      }
    }

    return current;
  }

  /// Fully resolves a $ref string to its target value.
  ///
  /// Handles both internal and external references.
  dynamic resolve(String ref, String currentPath) {
    final resolved = parseReference(ref, currentPath);

    // Load document if external
    final document = resolved.isExternal
        ? loadExternalDocument(resolved.documentPath)
        : _loadedDocuments[resolved.documentPath] ?? {};

    // Resolve pointer within document
    return resolvePointer(document, resolved.jsonPointer);
  }

  /// Validates the format of a $ref string according to OpenAPI 3.0.0 and JSON Reference specs.
  /// Checks for proper URI format, JSON pointer syntax, and encoding.
  void validateRefFormat(String ref, String path) {
    if (ref.isEmpty) {
      validationContext.addException(
        OpenApiValidationException(
          path,
          '\$ref cannot be an empty string',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      return;
    }

    if (ref.startsWith('#')) {
      // Internal reference - validate JSON pointer format
      if (ref.length == 1) {
        validationContext.addException(
          OpenApiValidationException(
            path,
            '\$ref "#" is invalid - must include JSON pointer',
            specReference: 'RFC 6901 - JSON Pointer',
            severity: ValidationSeverity.critical,
          ),
        );
        return;
      }

      final jsonPointer = ref.substring(1);
      if (!jsonPointer.startsWith('/')) {
        validationContext.addException(
          OpenApiValidationException(
            path,
            '\$ref "$ref" is invalid - JSON pointer must start with "/" after "#"',
            specReference: 'RFC 6901 - JSON Pointer',
            severity: ValidationSeverity.critical,
          ),
        );
      }

      // Validate JSON pointer encoding
      _validateJsonPointerEncoding(jsonPointer, path, ref);
    } else {
      // External reference - validate URI and optional fragment
      if (ref.contains('#')) {
        final parts = ref.split('#');
        if (parts[0].isEmpty) {
          validationContext.addException(
            OpenApiValidationException(
              path,
              '\$ref "$ref" is invalid - document path cannot be empty before "#"',
              specReference: 'OpenAPI 3.0.0 - Reference Object',
              severity: ValidationSeverity.critical,
            ),
          );
          return;
        }

        if (parts.length > 1 && parts[1].isNotEmpty && !parts[1].startsWith('/')) {
          validationContext.addException(
            OpenApiValidationException(
              path,
              '\$ref "$ref" is invalid - fragment must be a valid JSON pointer starting with "/"',
              specReference: 'RFC 6901 - JSON Pointer',
              severity: ValidationSeverity.critical,
            ),
          );
        }

        // Validate JSON pointer in fragment if present
        if (parts.length > 1 && parts[1].isNotEmpty) {
          _validateJsonPointerEncoding(parts[1], path, ref);
        }
      }

      // Validate file extension (moderate severity, not critical)
      final filePath = ref.split('#')[0];
      if (!filePath.endsWith('.yaml') && !filePath.endsWith('.yml') && !filePath.endsWith('.json')) {
        validationContext.addException(
          OpenApiValidationException(
            path,
            '\$ref "$ref" should reference a .yaml, .yml, or .json file',
            specReference: 'OpenAPI 3.0.0 - Reference Object',
            severity: ValidationSeverity.moderate,
          ),
        );
      }
    }
  }

  /// Validates JSON pointer encoding according to RFC 6901.
  /// JSON pointers can only use ~0 (for ~) and ~1 (for /) escape sequences.
  void _validateJsonPointerEncoding(String pointer, String path, String fullRef) {
    // Check for invalid escape sequences (~ not followed by 0 or 1)
    final invalidEscape = RegExp(r'~(?![01])');
    if (invalidEscape.hasMatch(pointer)) {
      validationContext.addException(
        OpenApiValidationException(
          path,
          '\$ref "$fullRef" contains invalid escape sequence in JSON pointer - only ~0 and ~1 are allowed',
          specReference: 'RFC 6901 - JSON Pointer',
          severity: ValidationSeverity.critical,
        ),
      );
    }

    // Check for trailing ~ without 0 or 1
    if (pointer.endsWith('~')) {
      validationContext.addException(
        OpenApiValidationException(
          path,
          '\$ref "$fullRef" contains incomplete escape sequence at end of JSON pointer',
          specReference: 'RFC 6901 - JSON Pointer',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }

  /// Resolves a $ref string to its target JSON, document, and JSON pointer.
  /// Returns: (JSON, document, jsonPointer) - the target's content, document path, and JSON pointer
  /// Throws ValidationException if reference is invalid or not found.
  (Map<String, dynamic>, String, String) resolveReference(String ref, String currentPath) {
    // Validate format
    validateRefFormat(ref, '$currentPath/\$ref');

    // Parse reference
    final resolved = parseReference(ref, currentPath);

    // Load target document
    Map<dynamic, dynamic> targetDoc;
    if (resolved.isExternal) {
      targetDoc = loadExternalDocument(resolved.documentPath);
    } else {
      // For internal references, we need to infer the document from base file
      targetDoc = OpenApiGraph.i.getLoadedDocument(OpenApiGraph.i.rootDocumentName);
    }

    // Resolve pointer
    final targetJson = resolvePointer(targetDoc, resolved.jsonPointer);

    if (targetJson == null) {
      validationContext.addException(
        OpenApiValidationException(
          currentPath,
          'Reference not found: $ref',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      throw OpenApiValidationException(
        currentPath,
        'Reference not found: $ref',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
        severity: ValidationSeverity.critical,
      );
    }

    // Get relative document path
    final relativeDocPath = OpenApiGraph.i.getRelativeDocumentPath(resolved.documentPath);

    return (targetJson as Map<String, dynamic>, relativeDocPath, resolved.jsonPointer);
  }
}

/// Represents a parsed $ref reference.
class ResolvedReference {
  final String documentPath;
  final String jsonPointer;
  final bool isExternal;

  ResolvedReference({required this.documentPath, required this.jsonPointer, required this.isExternal});

  @override
  String toString() => isExternal ? '$documentPath#$jsonPointer' : '#$jsonPointer';
}

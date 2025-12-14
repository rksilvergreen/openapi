import 'dart:io';
import 'package:yaml/yaml.dart';
import '../../validation_exception.dart';
import '../validation/validation_context.dart';

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
      return ResolvedReference(
        documentPath: externalPath,
        jsonPointer: '/',
        isExternal: true,
      );
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
      validationContext.addException(OpenApiValidationException(
        '/',
        'External reference file not found: $documentPath',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
        severity: ValidationSeverity.critical,
      ));
      return {};
    }

    try {
      final yamlContent = file.readAsStringSync();
      final yamlDoc = loadYaml(yamlContent);
      
      if (yamlDoc is! Map) {
        validationContext.addException(OpenApiValidationException(
          '/',
          'External document must be an object: $documentPath',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ));
        return {};
      }

      _loadedDocuments[documentPath] = yamlDoc;
      return yamlDoc;
    } catch (e) {
      validationContext.addException(OpenApiValidationException(
        '/',
        'Failed to load external document: $documentPath. Error: $e',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
        severity: ValidationSeverity.critical,
      ));
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
}

/// Represents a parsed $ref reference.
class ResolvedReference {
  final String documentPath;
  final String jsonPointer;
  final bool isExternal;

  ResolvedReference({
    required this.documentPath,
    required this.jsonPointer,
    required this.isExternal,
  });

  @override
  String toString() => isExternal 
      ? '$documentPath#$jsonPointer'
      : '#$jsonPointer';
}


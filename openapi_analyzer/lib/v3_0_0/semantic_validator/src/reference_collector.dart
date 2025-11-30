import 'dart:io';

import 'json_pointer_resolver.dart';

/// Utility class to collect and validate internal references.
class ReferenceCollector {
  final Map<String, List<String>> internalReferences = {}; // ref -> paths where it's used
  final Map<String, List<String>> externalReferences = {}; // ref -> paths where it's used
  final String? baseDirectory; // Base directory for resolving external references

  ReferenceCollector({this.baseDirectory});

  /// Collects a reference usage.
  void addUsedReference(String ref, String path) {
    if (ref.startsWith('#/') || ref.startsWith('#')) {
      // Internal JSON Pointer reference
      internalReferences.putIfAbsent(ref, () => []);
      internalReferences[ref]!.add(path);
    } else {
      // External file reference
      externalReferences.putIfAbsent(ref, () => []);
      externalReferences[ref]!.add(path);
    }
  }

  /// Validates all references (internal and external).
  List<String> validateReferences(Map<dynamic, dynamic> document) {
    final errors = <String>[];
    final resolver = JsonPointerResolver();

    // Validate internal references
    for (final entry in internalReferences.entries) {
      final ref = entry.key;
      final paths = entry.value;

      if (!resolver.exists(document, ref)) {
        for (final path in paths) {
          errors.add('Internal reference "$ref" at path "$path" does not exist in the document');
        }
      }
    }

    // Validate external references
    for (final entry in externalReferences.entries) {
      final ref = entry.key;
      final paths = entry.value;

      // Check if external file exists
      String resolvedPath = ref;
      if (baseDirectory != null) {
        // Resolve relative path
        final refPath = ref.split('#')[0]; // Remove fragment if present
        resolvedPath = '$baseDirectory/$refPath';
      }

      final file = File(resolvedPath);
      if (!file.existsSync()) {
        for (final path in paths) {
          errors.add('External reference "$ref" at path "$path" points to non-existent file: $resolvedPath');
        }
      }
    }

    return errors;
  }
}


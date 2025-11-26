import 'reference_collector.dart';

/// Utility class for finding references in OpenAPI documents.
class ReferenceFinder {
  /// Recursively finds all $ref usages in the OpenAPI document.
  static void findReferences(dynamic data, String path, ReferenceCollector collector) {
    if (data is Map) {
      // Check if this map has a $ref
      if (data.containsKey(r'$ref')) {
        final ref = data[r'$ref'];
        if (ref is String) {
          collector.addUsedReference(ref, path);
        }
      }

      // Recursively check all values
      for (final entry in data.entries) {
        final key = entry.key.toString();
        final value = entry.value;
        findReferences(value, '$path/$key', collector);
      }
    } else if (data is List) {
      // Recursively check all list items
      for (var i = 0; i < data.length; i++) {
        findReferences(data[i], '$path[$i]', collector);
      }
    }
  }
}

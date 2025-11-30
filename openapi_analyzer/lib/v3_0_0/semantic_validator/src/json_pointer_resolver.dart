/// Utility class for resolving JSON Pointer references.
class JsonPointerResolver {
  /// Resolves a JSON Pointer reference like "#/components/schemas/Pet"
  /// Returns the referenced object or null if not found.
  dynamic resolve(Map<dynamic, dynamic> document, String ref) {
    // Handle the '#/' prefix
    if (!ref.startsWith('#/')) {
      return null;
    }

    // Remove the '#/' prefix
    final pointer = ref.substring(2);
    if (pointer.isEmpty) {
      return document;
    }

    // Split by '/' and traverse
    final parts = pointer.split('/');
    dynamic current = document;

    for (final part in parts) {
      // Decode JSON Pointer escaping
      final decodedPart = part.replaceAll('~1', '/').replaceAll('~0', '~');

      if (current is Map) {
        if (!current.containsKey(decodedPart)) {
          return null;
        }
        current = current[decodedPart];
      } else if (current is List) {
        final index = int.tryParse(decodedPart);
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

  /// Checks if a JSON Pointer reference exists in the document.
  bool exists(Map<dynamic, dynamic> document, String ref) {
    return resolve(document, ref) != null;
  }
}


/// Resolves JSON Pointers in an OpenAPI document.
class JsonPointerResolver {
  /// Resolves a JSON Pointer (RFC 6901) in the given data.
  /// Returns null if the pointer cannot be resolved.
  dynamic resolve(dynamic data, String pointer) {
    // Remove the leading '#' if present
    String cleanPointer = pointer;
    if (cleanPointer.startsWith('#')) {
      cleanPointer = cleanPointer.substring(1);
    }

    // Empty pointer refers to the whole document
    if (cleanPointer.isEmpty || cleanPointer == '/') {
      return data;
    }

    // Split the pointer into tokens
    final tokens = cleanPointer.split('/').skip(1); // Skip first empty string
    
    dynamic current = data;
    
    for (final token in tokens) {
      // Unescape the token (RFC 6901: ~1 -> /, ~0 -> ~)
      final unescapedToken = _unescapeToken(token);
      
      if (current is Map) {
        if (!current.containsKey(unescapedToken)) {
          return null; // Path not found
        }
        current = current[unescapedToken];
      } else if (current is List) {
        final index = int.tryParse(unescapedToken);
        if (index == null || index < 0 || index >= current.length) {
          return null; // Invalid array index
        }
        current = current[index];
      } else {
        return null; // Cannot navigate further
      }
    }
    
    return current;
  }

  /// Unescapes a JSON Pointer token according to RFC 6901.
  String _unescapeToken(String token) {
    return token
        .replaceAll('~1', '/')
        .replaceAll('~0', '~')
        // Also handle URL encoding
        .replaceAll('%7B', '{')
        .replaceAll('%7D', '}')
        .replaceAll('%2F', '/')
        .replaceAll('%20', ' ')
        .replaceAll('~2F', '/')
        .replaceAll('application~1json', 'application/json');
  }

  /// Checks if a JSON Pointer can be resolved in the given data.
  bool exists(dynamic data, String pointer) {
    return resolve(data, pointer) != null;
  }
}


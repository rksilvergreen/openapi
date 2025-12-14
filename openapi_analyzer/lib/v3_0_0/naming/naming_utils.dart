/// Utilities for generating names for operations and schemas.
class NamingUtils {
  /// Converts a string to PascalCase.
  /// 
  /// Examples:
  /// - "hello_world" -> "HelloWorld"
  /// - "get-user-by-id" -> "GetUserById"
  /// - "getUserById" -> "GetUserById"
  static String toPascalCase(String input) {
    if (input.isEmpty) return input;

    // Split on various delimiters
    final parts = input.split(RegExp(r'[_\-\s/]+'));
    
    return parts
        .where((part) => part.isNotEmpty)
        .map((part) => _capitalizeFirst(part))
        .join('');
  }

  /// Capitalizes the first letter of a string.
  static String _capitalizeFirst(String input) {
    if (input.isEmpty) return input;
    
    // Handle camelCase by splitting on uppercase letters
    final camelParts = input.split(RegExp(r'(?=[A-Z])'));
    if (camelParts.length > 1) {
      return camelParts.map((p) => _capitalizeFirst(p)).join('');
    }
    
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  /// Generates an operation name from a path and HTTP method.
  /// 
  /// Examples:
  /// - path: "/v2/oauth/token", method: "post" -> "V2OauthTokenPost"
  /// - path: "/users/{id}", method: "get" -> "UsersIdGet"
  /// - path: "/api/users", method: "get" -> "ApiUsersGet"
  static String operationNameFromPath(String path, String httpMethod) {
    // Remove leading/trailing slashes
    var cleanPath = path.trim();
    if (cleanPath.startsWith('/')) {
      cleanPath = cleanPath.substring(1);
    }
    if (cleanPath.endsWith('/')) {
      cleanPath = cleanPath.substring(0, cleanPath.length - 1);
    }

    // Replace path parameters {id} with just the parameter name
    cleanPath = cleanPath.replaceAllMapped(
      RegExp(r'\{([^}]+)\}'),
      (match) => match.group(1) ?? '',
    );

    // Convert to PascalCase and append method
    final pathPart = toPascalCase(cleanPath);
    final methodPart = toPascalCase(httpMethod);
    
    return '$pathPart$methodPart';
  }

  /// Extracts the component key from a JSON pointer path.
  /// 
  /// Example: "/components/schemas/User" -> "User"
  static String? extractComponentKey(String jsonPointer) {
    final parts = jsonPointer.split('/');
    if (parts.length >= 4 && parts[1] == 'components') {
      return toPascalCase(parts.last);
    }
    return null;
  }

  /// Extracts the property name from a JSON pointer path.
  /// 
  /// Example: "/properties/firstName" -> "firstName"
  static String? extractPropertyName(String jsonPointer) {
    final parts = jsonPointer.split('/');
    if (parts.length >= 2) {
      return parts.last;
    }
    return null;
  }

  /// Sanitizes a name by removing invalid characters.
  static String sanitizeName(String name) {
    // Remove any characters that aren't alphanumeric or underscore
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
  }

  /// Ensures a name is a valid Dart identifier.
  static String toValidDartIdentifier(String name) {
    var result = sanitizeName(name);
    
    // Ensure it doesn't start with a number
    if (result.isNotEmpty && RegExp(r'^[0-9]').hasMatch(result)) {
      result = '\$$result';
    }
    
    // Ensure it's not empty
    if (result.isEmpty) {
      result = 'unnamed';
    }
    
    return result;
  }

  /// Converts a status code to a readable name.
  /// 
  /// Examples:
  /// - "200" -> "200"
  /// - "default" -> "Default"
  static String statusCodeToName(String statusCode) {
    if (statusCode == 'default') {
      return 'Default';
    }
    return statusCode;
  }
}


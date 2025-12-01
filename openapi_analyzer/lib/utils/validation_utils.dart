import '../validation_exception.dart';

/// Utility class for validation operations.
class ValidationUtils {
  /// Builds a JSON-like path string for error messages.
  static String buildPath(String current, String next) {
    if (current.isEmpty) {
      return next;
    }
    return '$current/$next';
  }

  /// Ensures a required field exists in the data map.
  /// Throws [OpenApiValidationException] if the field is missing.
  static T requireField<T>(Map<dynamic, dynamic> data, String field, String path) {
    if (!data.containsKey(field)) {
      throw OpenApiValidationException(
        buildPath(path, field),
        'Required field "$field" is missing',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    final value = data[field];
    return value as T;
  }

  /// Validates that a value is of the expected type.
  /// Throws [OpenApiValidationException] if the type doesn't match.
  static void validateType(dynamic value, Type expected, String path) {
    if (value.runtimeType != expected) {
      throw OpenApiValidationException(
        path,
        'Expected type ${expected.toString()}, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates that a value is a string matching the given pattern.
  /// Throws [OpenApiValidationException] if the pattern doesn't match.
  static void validatePattern(String value, String pattern, String path) {
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      throw OpenApiValidationException(
        path,
        'Value "$value" does not match required pattern: $pattern',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates that a value is one of the allowed enum values.
  /// Throws [OpenApiValidationException] if the value is not in the allowed list.
  static void validateEnum(String value, List<String> allowed, String path) {
    if (!allowed.contains(value)) {
      throw OpenApiValidationException(
        path,
        'Value "$value" is not one of the allowed values: ${allowed.join(", ")}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates that a numeric value is non-negative.
  /// Throws [OpenApiValidationException] if the value is negative.
  static void validateNonNegative(num value, String path) {
    if (value < 0) {
      throw OpenApiValidationException(
        path,
        'Value must be non-negative, got $value',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates that a numeric value is strictly greater than zero.
  /// Throws [OpenApiValidationException] if the value is not > 0.
  static void validatePositive(num value, String path) {
    if (value <= 0) {
      throw OpenApiValidationException(
        path,
        'Value must be strictly greater than 0, got $value',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates that a value is a Map.
  /// Throws [OpenApiValidationException] if not a Map.
  static Map<dynamic, dynamic> requireMap(dynamic value, String path) {
    if (value is! Map) {
      throw OpenApiValidationException(
        path,
        'Expected Map, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that a value is a List.
  /// Throws [OpenApiValidationException] if not a List.
  static List<dynamic> requireList(dynamic value, String path) {
    if (value is! List) {
      throw OpenApiValidationException(
        path,
        'Expected List, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that a value is a String.
  /// Throws [OpenApiValidationException] if not a String.
  static String requireString(dynamic value, String path) {
    if (value is! String) {
      throw OpenApiValidationException(
        path,
        'Expected String, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that a value is a boolean.
  /// Throws [OpenApiValidationException] if not a boolean.
  static bool requireBool(dynamic value, String path) {
    if (value is! bool) {
      throw OpenApiValidationException(
        path,
        'Expected bool, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that a value is a number (int or double).
  /// Throws [OpenApiValidationException] if not a number.
  static num requireNumber(dynamic value, String path) {
    if (value is! num) {
      throw OpenApiValidationException(
        path,
        'Expected number, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that the data object only contains allowed fields.
  /// Throws an exception if any unrecognized fields are present.
  /// Extension fields (starting with 'x-') are always allowed.
  static void validateNoUnknownFields(Map<dynamic, dynamic> data, Set<String> allowedFields, String path, String objectType) {
    final unknownFields = <String>[];

    for (final key in data.keys) {
      final keyStr = key.toString();
      // Allow extension fields (x-*)
      if (keyStr.startsWith('x-')) {
        continue;
      }

      if (!allowedFields.contains(keyStr)) {
        unknownFields.add(keyStr);
      }
    }

    if (unknownFields.isNotEmpty) {
      final sortedAllowed = allowedFields.toList()..sort();
      throw OpenApiValidationException(
        path,
        'Unknown field(s) in $objectType: ${unknownFields.join(", ")}. Allowed fields: ${sortedAllowed.join(", ")}',
        specReference: 'OpenAPI 3.0.0 - $objectType',
        severity: ValidationSeverity.critical,
      );
    }
  }
}

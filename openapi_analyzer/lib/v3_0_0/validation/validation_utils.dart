import '../../validation_exception.dart';

/// Utility class for common validation operations.
class ValidationUtils {
  /// Builds a JSON Pointer path string for error messages.
  static String buildPath(String current, String next) {
    if (current.isEmpty || current == '/') {
      return '/$next';
    }
    return '$current/$next';
  }

  /// Ensures a required field exists in the data map.
  /// Throws [OpenApiValidationException] if the field is missing.
  static dynamic requireField(Map<dynamic, dynamic> data, String field, String path) {
    if (!data.containsKey(field)) {
      throw OpenApiValidationException(
        buildPath(path, field),
        'Required field "$field" is missing',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return data[field];
  }

  /// Validates that a value is a Map.
  /// Throws [OpenApiValidationException] if not a Map.
  static Map<dynamic, dynamic> requireMap(dynamic value, String path) {
    if (value is! Map) {
      throw OpenApiValidationException(
        path,
        'Expected object (Map), got ${value.runtimeType}',
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
        'Expected array (List), got ${value.runtimeType}',
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
        'Expected string, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that a value is a non-empty String.
  /// Throws [OpenApiValidationException] if not a non-empty String.
  static String requireNonEmptyString(dynamic value, String path) {
    final str = requireString(value, path);
    if (str.isEmpty) {
      throw OpenApiValidationException(
        path,
        'String cannot be empty',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return str;
  }

  /// Validates that a value is a boolean.
  /// Throws [OpenApiValidationException] if not a boolean.
  static bool requireBool(dynamic value, String path) {
    if (value is! bool) {
      throw OpenApiValidationException(
        path,
        'Expected boolean, got ${value.runtimeType}',
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

  /// Validates that a value is an integer.
  /// Throws [OpenApiValidationException] if not an integer.
  static int requireInt(dynamic value, String path) {
    if (value is! int) {
      throw OpenApiValidationException(
        path,
        'Expected integer, got ${value.runtimeType}',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
    return value;
  }

  /// Validates that a string value matches the given pattern.
  /// Throws [OpenApiValidationException] if the pattern doesn't match.
  static void validatePattern(String value, String pattern, String path, {String? description}) {
    try {
      final regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        throw OpenApiValidationException(
          path,
          description ?? 'Value "$value" does not match required pattern: $pattern',
          specReference: 'OpenAPI 3.0.0 Specification',
          severity: ValidationSeverity.critical,
        );
      }
    } catch (e) {
      throw OpenApiValidationException(
        path,
        'Invalid regex pattern: $pattern',
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

  /// Validates that a numeric range is valid (min <= max).
  /// Throws [OpenApiValidationException] if the range is invalid.
  static void validateRange(num? min, num? max, String path, {String? minName, String? maxName}) {
    if (min != null && max != null && min > max) {
      throw OpenApiValidationException(
        path,
        '${minName ?? "minimum"} ($min) cannot be greater than ${maxName ?? "maximum"} ($max)',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates that the data object only contains allowed fields.
  /// Extension fields (starting with 'x-') are always allowed.
  /// Throws [OpenApiValidationException] if any unrecognized fields are present.
  static void validateNoUnknownFields(
    Map<dynamic, dynamic> data,
    Set<String> allowedFields,
    String path,
    String objectType,
  ) {
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

  /// Validates that a regex pattern is valid.
  static void validateRegexPattern(String pattern, String path) {
    try {
      RegExp(pattern);
    } catch (e) {
      throw OpenApiValidationException(
        path,
        'Invalid regex pattern: $pattern. Error: $e',
        specReference: 'OpenAPI 3.0.0 Specification',
        severity: ValidationSeverity.critical,
      );
    }
  }
}


import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Structural validator for Server Variable Objects (OpenAPI 3.0.0).
class ServerVariableObjectStructuralValidator {
  /// Validates the structural correctness of a Server Variable Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    final defaultValue = _validateDefaultField(data, path);
    _validateEnumField(data, path, defaultValue);
    _validateDescriptionField(data, path);
    _validateAllowedFields(data, path);
  }

  static String _validateDefaultField(Map<dynamic, dynamic> data, String path) {
    return ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'default', path),
      ValidationUtils.buildPath(path, 'default'),
    );
  }

  static void _validateEnumField(Map<dynamic, dynamic> data, String path, String defaultValue) {
    if (data.containsKey('enum')) {
      final enumValues = ValidationUtils.requireList(data['enum'], ValidationUtils.buildPath(path, 'enum'));
      _validateEnumNotEmpty(enumValues, path);
      _validateEnumValues(enumValues, path);
      _validateDefaultInEnum(enumValues, defaultValue, path);
    }
  }

  static void _validateEnumNotEmpty(List<dynamic> enumValues, String path) {
    if (enumValues.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'enum'),
        'Server variable enum array cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Server Variable Object',
      );
    }
  }

  static void _validateEnumValues(List<dynamic> enumValues, String path) {
    for (var i = 0; i < enumValues.length; i++) {
      ValidationUtils.requireString(enumValues[i], ValidationUtils.buildPath(path, 'enum[$i]'));
    }
  }

  static void _validateDefaultInEnum(List<dynamic> enumValues, String defaultValue, String path) {
    if (!enumValues.contains(defaultValue)) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'default'),
        'Server variable default value "$defaultValue" must be one of the enum values',
        specReference: 'OpenAPI 3.0.0 - Server Variable Object',
      );
    }
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'enum', 'default', 'description'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Server Variable Object');
  }
}


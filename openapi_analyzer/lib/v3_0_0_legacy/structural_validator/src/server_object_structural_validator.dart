import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';
import 'server_variable_object_structural_validator.dart';

/// Structural validator for Server Objects (OpenAPI 3.0.0).
class ServerObjectStructuralValidator {
  /// Validates the structural correctness of a Server Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateUrlField(data, path);
    _validateDescriptionField(data, path);
    _validateVariablesField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateUrlField(Map<dynamic, dynamic> data, String path) {
    final url = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'url', path),
      ValidationUtils.buildPath(path, 'url'),
    );

    if (url.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'url'),
        'Server url cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Server Object',
        severity: ValidationSeverity.critical,
      );
    }
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateVariablesField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('variables')) {
      final variables = ValidationUtils.requireMap(data['variables'], ValidationUtils.buildPath(path, 'variables'));
      for (final key in variables.keys) {
        final keyStr = key.toString();
        _validateVariable(variables[key], keyStr, path);
      }
    }
  }

  static void _validateVariable(dynamic variable, String keyStr, String path) {
    if (variable is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'variables.$keyStr'),
        'Server variable must be a Server Variable Object',
        specReference: 'OpenAPI 3.0.0 - Server Object',
        severity: ValidationSeverity.critical,
      );
    }
    ServerVariableObjectStructuralValidator.validate(
      variable,
      ValidationUtils.buildPath(path, 'variables.$keyStr'),
    );
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'url', 'description', 'variables'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Server Object');
  }
}


import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Structural validator for Path Item Objects (OpenAPI 3.0.0).
class PathItemObjectStructuralValidator {
  /// Validates the structural correctness of a Path Item Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    // Validate allowed HTTP methods and fields
    _validateAllowedFields(data, path);

    // Validate each operation if present
    const httpMethods = ['get', 'put', 'post', 'delete', 'options', 'head', 'patch', 'trace'];
    for (final method in httpMethods) {
      if (data.containsKey(method)) {
        final operation = data[method];
        if (operation is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, method),
            'Operation must be an Operation Object',
            specReference: 'OpenAPI 3.0.0 - Path Item Object',
          );
        }
        // Operation validation would go here
        _validateOperationObject(operation, ValidationUtils.buildPath(path, method));
      }
    }

    // Validate parameters if present
    if (data.containsKey('parameters')) {
      final parameters = ValidationUtils.requireList(data['parameters'], ValidationUtils.buildPath(path, 'parameters'));
      for (var i = 0; i < parameters.length; i++) {
        if (parameters[i] is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'parameters[$i]'),
            'Parameter must be a Parameter Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Path Item Object',
          );
        }
      }
    }

    // Validate description if present
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate summary if present
    if (data.containsKey('summary')) {
      ValidationUtils.requireString(data['summary'], ValidationUtils.buildPath(path, 'summary'));
    }
  }

  static void _validateOperationObject(Map<dynamic, dynamic> data, String path) {
    // Basic structural validation of operation object
    // Validate responses is required
    if (!data.containsKey('responses')) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'responses'),
        'Operation must have a responses field',
        specReference: 'OpenAPI 3.0.0 - Operation Object',
      );
    }

    if (data['responses'] is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'responses'),
        'responses must be a Responses Object',
        specReference: 'OpenAPI 3.0.0 - Operation Object',
      );
    }

    // Validate optional fields types
    if (data.containsKey('summary')) {
      ValidationUtils.requireString(data['summary'], ValidationUtils.buildPath(path, 'summary'));
    }
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
    if (data.containsKey('operationId')) {
      ValidationUtils.requireString(data['operationId'], ValidationUtils.buildPath(path, 'operationId'));
    }
    if (data.containsKey('parameters')) {
      ValidationUtils.requireList(data['parameters'], ValidationUtils.buildPath(path, 'parameters'));
    }
    if (data.containsKey('requestBody')) {
      ValidationUtils.requireMap(data['requestBody'], ValidationUtils.buildPath(path, 'requestBody'));
    }
    if (data.containsKey('deprecated')) {
      ValidationUtils.requireBool(data['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      r'$ref',
      'summary',
      'description',
      'get',
      'put',
      'post',
      'delete',
      'options',
      'head',
      'patch',
      'trace',
      'servers',
      'parameters',
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Path Item Object');
  }
}

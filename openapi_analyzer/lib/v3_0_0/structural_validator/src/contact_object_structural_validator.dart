import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Structural validator for Contact Objects (OpenAPI 3.0.0).
/// All fields are optional.
class ContactObjectStructuralValidator {
  /// Validates the structural correctness of a Contact Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateNameField(data, path);
    _validateUrlField(data, path);
    _validateEmailField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateNameField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('name')) {
      ValidationUtils.requireString(data['name'], ValidationUtils.buildPath(path, 'name'));
    }
  }

  static void _validateUrlField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('url')) {
      final url = ValidationUtils.requireString(data['url'], ValidationUtils.buildPath(path, 'url'));
      if (url.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'url'),
          'Contact url cannot be empty',
          specReference: 'OpenAPI 3.0.0 - Contact Object',
        );
      }
    }
  }

  static void _validateEmailField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('email')) {
      final email = ValidationUtils.requireString(data['email'], ValidationUtils.buildPath(path, 'email'));
      if (email.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'email'),
          'Contact email cannot be empty',
          specReference: 'OpenAPI 3.0.0 - Contact Object',
        );
      }
      // Basic email format check (contains @)
      if (!email.contains('@')) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'email'),
          'Contact email must be in valid email format',
          specReference: 'OpenAPI 3.0.0 - Contact Object',
        );
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'name', 'url', 'email'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Contact Object');
  }
}


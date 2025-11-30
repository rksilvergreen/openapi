import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Structural validator for License Objects (OpenAPI 3.0.0).
class LicenseObjectStructuralValidator {
  /// Validates the structural correctness of a License Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateNameField(data, path);
    _validateUrlField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateNameField(Map<dynamic, dynamic> data, String path) {
    ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'name', path),
      ValidationUtils.buildPath(path, 'name'),
    );
  }

  static void _validateUrlField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('url')) {
      final url = ValidationUtils.requireString(data['url'], ValidationUtils.buildPath(path, 'url'));
      if (url.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'url'),
          'License url cannot be empty',
          specReference: 'OpenAPI 3.0.0 - License Object',
        );
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'name', 'url'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'License Object');
  }
}


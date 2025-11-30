import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';
import 'contact_object_structural_validator.dart';
import 'license_object_structural_validator.dart';

/// Structural validator for Info Objects (OpenAPI 3.0.0).
class InfoObjectStructuralValidator {
  /// Validates the structural correctness of an Info Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateTitleField(data, path);
    _validateVersionField(data, path);
    _validateDescriptionField(data, path);
    _validateTermsOfServiceField(data, path);
    _validateContactField(data, path);
    _validateLicenseField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateTitleField(Map<dynamic, dynamic> data, String path) {
    final title = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'title', path),
      ValidationUtils.buildPath(path, 'title'),
    );

    if (title.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'title'),
        'Info title cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Info Object',
      );
    }
  }

  static void _validateVersionField(Map<dynamic, dynamic> data, String path) {
    final version = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'version', path),
      ValidationUtils.buildPath(path, 'version'),
    );

    if (version.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'version'),
        'Info version cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Info Object',
      );
    }
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateTermsOfServiceField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('termsOfService')) {
      final termsOfService = ValidationUtils.requireString(
        data['termsOfService'],
        ValidationUtils.buildPath(path, 'termsOfService'),
      );
      if (termsOfService.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'termsOfService'),
          'Info termsOfService cannot be empty',
          specReference: 'OpenAPI 3.0.0 - Info Object',
        );
      }
    }
  }

  static void _validateContactField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('contact')) {
      final contact = ValidationUtils.requireMap(data['contact'], ValidationUtils.buildPath(path, 'contact'));
      ContactObjectStructuralValidator.validate(contact, ValidationUtils.buildPath(path, 'contact'));
    }
  }

  static void _validateLicenseField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('license')) {
      final license = ValidationUtils.requireMap(data['license'], ValidationUtils.buildPath(path, 'license'));
      LicenseObjectStructuralValidator.validate(license, ValidationUtils.buildPath(path, 'license'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'title', 'version', 'description', 'termsOfService', 'contact', 'license'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Info Object');
  }
}

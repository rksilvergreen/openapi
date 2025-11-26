import 'validation_utils.dart';

/// Validator for Discriminator Objects according to OpenAPI 3.0.0 specification.
class DiscriminatorObjectValidator {
  /// Validates a Discriminator Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validatePropertyNameField(data, path);
    _validateMappingField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validatePropertyNameField(Map<dynamic, dynamic> data, String path) {
    ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'propertyName', path),
      ValidationUtils.buildPath(path, 'propertyName'),
    );
  }

  static void _validateMappingField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('mapping')) {
      final mapping = ValidationUtils.requireMap(data['mapping'], ValidationUtils.buildPath(path, 'mapping'));
      for (final key in mapping.keys) {
        final keyStr = key.toString();
        final value = mapping[key];
        ValidationUtils.requireString(value, ValidationUtils.buildPath(path, 'mapping.$keyStr'));
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'propertyName', 'mapping'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Discriminator Object');
  }
}

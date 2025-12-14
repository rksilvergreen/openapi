import 'validation_exception.dart';
import 'validation_utils.dart';
import 'schema_object_validator.dart';

/// Validator for Media Type Objects according to OpenAPI 3.0.0 specification.
class MediaTypeObjectValidator {
  /// Validates a Media Type Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateSchemaField(data, path);
    _validateExampleFields(data, path);
    _validateEncodingField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateSchemaField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('schema')) {
      final schema = ValidationUtils.requireMap(data['schema'], ValidationUtils.buildPath(path, 'schema'));
      SchemaObjectValidator.validate(schema, ValidationUtils.buildPath(path, 'schema'));
    }
  }

  static void _validateExampleFields(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('example') && data.containsKey('examples')) {
      throw OpenApiValidationException(
        path,
        'Media Type Object cannot have both example and examples',
        specReference: 'OpenAPI 3.0.0 - Media Type Object',
      );
    }
  }

  static void _validateEncodingField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('encoding')) {
      ValidationUtils.requireMap(data['encoding'], ValidationUtils.buildPath(path, 'encoding'));
      // Encoding Object validation is handled separately
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'schema', 'example', 'examples', 'encoding'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Media Type Object');
  }
}

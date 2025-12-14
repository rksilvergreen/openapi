import 'validation_exception.dart';
import 'validation_utils.dart';
import 'media_type_object_validator.dart';

/// Validator for Request Body Objects according to OpenAPI 3.0.0 specification.
class RequestBodyObjectValidator {
  /// Validates a Request Body Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateContentField(data, path);
    _validateDescriptionField(data, path);
    _validateRequiredField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateContentField(Map<dynamic, dynamic> data, String path) {
    final content = ValidationUtils.requireMap(ValidationUtils.requireField(data, 'content', path), ValidationUtils.buildPath(path, 'content'));

    if (content.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'content'),
        'Request Body content map cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Request Body Object',
      );
    }

    _validateMediaTypes(content, path);
  }

  static void _validateMediaTypes(Map<dynamic, dynamic> content, String path) {
    for (final key in content.keys) {
      final keyStr = key.toString();
      _validateMediaType(content[key], keyStr, path);
    }
  }

  static void _validateMediaType(dynamic mediaType, String keyStr, String path) {
    if (mediaType is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'content.$keyStr'),
        'Media type must be a Media Type Object',
        specReference: 'OpenAPI 3.0.0 - Request Body Object',
      );
    }
    MediaTypeObjectValidator.validate(mediaType, ValidationUtils.buildPath(path, 'content.$keyStr'));
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateRequiredField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('required')) {
      ValidationUtils.requireBool(data['required'], ValidationUtils.buildPath(path, 'required'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'description', 'content', 'required'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Request Body Object');
  }
}

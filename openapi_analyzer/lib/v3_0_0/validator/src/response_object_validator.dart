import 'validation_exception.dart';
import 'validation_utils.dart';
import 'header_object_validator.dart';
import 'media_type_object_validator.dart';

/// Validator for Response Objects according to OpenAPI 3.0.0 specification.
class ResponseObjectValidator {
  /// Validates a Response Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateDescriptionField(data, path);
    _validateHeadersField(data, path);
    _validateContentField(data, path);
    _validateLinksField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    final description = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'description', path),
      ValidationUtils.buildPath(path, 'description'),
    );

    if (description.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'description'),
        'Response description cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Response Object',
      );
    }
  }

  static void _validateHeadersField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('headers')) {
      final headers = ValidationUtils.requireMap(data['headers'], ValidationUtils.buildPath(path, 'headers'));
      for (final key in headers.keys) {
        final keyStr = key.toString();
        _validateHeader(headers[key], keyStr, path);
      }
    }
  }

  static void _validateHeader(dynamic header, String keyStr, String path) {
    if (header is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'headers.$keyStr'),
        'Header must be a Header Object',
        specReference: 'OpenAPI 3.0.0 - Response Object',
      );
    }
    HeaderObjectValidator.validate(header, ValidationUtils.buildPath(path, 'headers.$keyStr'));
  }

  static void _validateContentField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('content')) {
      final content = ValidationUtils.requireMap(data['content'], ValidationUtils.buildPath(path, 'content'));
      for (final key in content.keys) {
        final keyStr = key.toString();
        _validateMediaType(content[key], keyStr, path);
      }
    }
  }

  static void _validateMediaType(dynamic mediaType, String keyStr, String path) {
    if (mediaType is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'content.$keyStr'),
        'Media type must be a Media Type Object',
        specReference: 'OpenAPI 3.0.0 - Response Object',
      );
    }
    MediaTypeObjectValidator.validate(mediaType, ValidationUtils.buildPath(path, 'content.$keyStr'));
  }

  static void _validateLinksField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('links')) {
      ValidationUtils.requireMap(data['links'], ValidationUtils.buildPath(path, 'links'));
      // Link Object validation is handled separately
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {'description', 'headers', 'content', 'links'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Response Object');
  }
}

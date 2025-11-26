import 'validation_exception.dart';
import 'validation_utils.dart';
import 'reference_object_validator.dart';
import 'response_object_validator.dart';

/// Validator for Responses Objects according to OpenAPI 3.0.0 specification.
class ResponsesObjectValidator {
  /// Validates a Responses Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateNotEmpty(data, path);
    _validateResponseCodes(data, path);
  }

  static void _validateNotEmpty(Map<dynamic, dynamic> data, String path) {
    if (data.isEmpty) {
      throw OpenApiValidationException(
        path,
        'Responses Object MUST contain at least one response code',
        specReference: 'OpenAPI 3.0.0 - Responses Object',
      );
    }
  }

  static void _validateResponseCodes(Map<dynamic, dynamic> data, String path) {
    for (final key in data.keys) {
      final keyStr = key.toString();
      _validateResponseCode(keyStr, path);
      _validateResponseObject(data[key], keyStr, path);
    }
  }

  static void _validateResponseCode(String keyStr, String path) {
    if (keyStr != 'default' && !_isValidHttpStatusCode(keyStr)) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, keyStr),
        'Response key must be an HTTP status code or "default", got: $keyStr',
        specReference: 'OpenAPI 3.0.0 - Responses Object',
      );
    }
  }

  static void _validateResponseObject(dynamic response, String keyStr, String path) {
    if (response is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, keyStr),
        'Response must be a Response Object or Reference Object',
        specReference: 'OpenAPI 3.0.0 - Responses Object',
      );
    }

    final responseMap = response;

    // Check if it's a reference
    if (responseMap.containsKey(r'$ref')) {
      ReferenceObjectValidator.validate(responseMap, ValidationUtils.buildPath(path, keyStr));
    } else {
      ResponseObjectValidator.validate(responseMap, ValidationUtils.buildPath(path, keyStr));
    }
  }

  static bool _isValidHttpStatusCode(String code) {
    // Check for range format (1XX, 2XX, 3XX, 4XX, 5XX)
    if (RegExp(r'^[1-5]XX$').hasMatch(code)) {
      return true;
    }

    // Check for specific status code (100-599)
    final statusCode = int.tryParse(code);
    if (statusCode != null && statusCode >= 100 && statusCode <= 599) {
      return true;
    }

    return false;
  }
}

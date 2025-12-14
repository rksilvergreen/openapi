import 'validation_exception.dart';
import 'validation_utils.dart';

/// Validator for Reference Objects according to OpenAPI 3.0.0 specification.
/// A Reference Object MUST have only a $ref field and no additional properties.
class ReferenceObjectValidator {
  /// Validates a Reference Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateRefField(data, path);
    _validateNoAdditionalProperties(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateRefField(Map<dynamic, dynamic> data, String path) {
    final ref = ValidationUtils.requireString(ValidationUtils.requireField(data, r'$ref', path), ValidationUtils.buildPath(path, r'$ref'));

    // $ref MUST be a string
    if (ref.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, r'$ref'),
        'Reference Object \$ref field cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
      );
    }
  }

  static void _validateNoAdditionalProperties(Map<dynamic, dynamic> data, String path) {
    // Reference Object cannot have additional properties beyond $ref
    // (except specification extensions x-*)
    const allowedKeys = {r'$ref'};
    for (final key in data.keys) {
      final keyStr = key.toString();
      if (!allowedKeys.contains(keyStr) && !keyStr.startsWith('x-')) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, keyStr),
          'Reference Object cannot have additional properties beyond \$ref. Found: $keyStr',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {r'$ref'};
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Reference Object');
  }
}

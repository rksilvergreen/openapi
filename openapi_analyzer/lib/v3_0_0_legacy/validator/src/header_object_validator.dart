import 'validation_exception.dart';
import 'validation_utils.dart';

/// Validator for Header Objects according to OpenAPI 3.0.0 specification.
/// Header Object follows the structure of Parameter Object with these changes:
/// - name MUST NOT be specified
/// - in MUST NOT be specified (implicitly in header)
class HeaderObjectValidator {
  /// Validates a Header Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateForbiddenFields(data, path);
    _validateOptionalFields(data, path);
    _validateStyleField(data, path);
    _validateSchemaField(data, path);
    _validateContentField(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateForbiddenFields(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('name')) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'name'),
        'Header Object MUST NOT have a name field',
        specReference: 'OpenAPI 3.0.0 - Header Object',
      );
    }

    if (data.containsKey('in')) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'in'),
        'Header Object MUST NOT have an in field',
        specReference: 'OpenAPI 3.0.0 - Header Object',
      );
    }
  }

  static void _validateOptionalFields(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }

    if (data.containsKey('required')) {
      ValidationUtils.requireBool(data['required'], ValidationUtils.buildPath(path, 'required'));
    }

    if (data.containsKey('deprecated')) {
      ValidationUtils.requireBool(data['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }

    if (data.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(data['allowEmptyValue'], ValidationUtils.buildPath(path, 'allowEmptyValue'));
    }

    if (data.containsKey('explode')) {
      ValidationUtils.requireBool(data['explode'], ValidationUtils.buildPath(path, 'explode'));
    }

    if (data.containsKey('allowReserved')) {
      ValidationUtils.requireBool(data['allowReserved'], ValidationUtils.buildPath(path, 'allowReserved'));
    }

    if (data.containsKey('example')) {
      // example can be any type
    }

    if (data.containsKey('examples')) {
      ValidationUtils.requireMap(data['examples'], ValidationUtils.buildPath(path, 'examples'));
      // Example validation is handled separately
    }
  }

  static void _validateStyleField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('style')) {
      final style = ValidationUtils.requireString(data['style'], ValidationUtils.buildPath(path, 'style'));
      const validStyles = ['simple'];
      ValidationUtils.validateEnum(style, validStyles, ValidationUtils.buildPath(path, 'style'));
    }
  }

  static void _validateSchemaField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('schema')) {
      ValidationUtils.requireMap(data['schema'], ValidationUtils.buildPath(path, 'schema'));
      // Schema validation is handled separately
    }
  }

  static void _validateContentField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('content')) {
      final content = ValidationUtils.requireMap(data['content'], ValidationUtils.buildPath(path, 'content'));
      // Content must have exactly one entry
      if (content.length != 1) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'content'),
          'Header content map MUST contain exactly one entry',
          specReference: 'OpenAPI 3.0.0 - Header Object',
        );
      }
      // Media Type Object validation is handled separately
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      'description',
      'required',
      'deprecated',
      'allowEmptyValue',
      'style',
      'explode',
      'allowReserved',
      'schema',
      'example',
      'examples',
      'content',
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Header Object');
  }
}

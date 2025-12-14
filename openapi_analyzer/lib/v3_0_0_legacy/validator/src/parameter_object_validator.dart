import 'validation_exception.dart';
import 'validation_utils.dart';
import 'schema_object_validator.dart';

/// Validator for Parameter Objects according to OpenAPI 3.0.0 specification.
class ParameterObjectValidator {
  /// Validates a Parameter Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validateRequiredFields(data, path);
    final inValue = data['in'] as String;
    
    _validateOptionalFields(data, path, inValue);
    _validateSchemaOrContent(data, path);
    _validateExampleFields(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateRequiredFields(Map<dynamic, dynamic> data, String path) {
    // name is REQUIRED
    ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'name', path),
      ValidationUtils.buildPath(path, 'name'),
    );

    // in is REQUIRED
    final inValue = ValidationUtils.requireString(
      ValidationUtils.requireField(data, 'in', path),
      ValidationUtils.buildPath(path, 'in'),
    );

    _validateInValue(inValue, path);
    _validatePathParameterRequired(data, inValue, path);
  }

  static void _validateInValue(String inValue, String path) {
    const validInValues = ['query', 'header', 'path', 'cookie'];
    ValidationUtils.validateEnum(inValue, validInValues, ValidationUtils.buildPath(path, 'in'));
  }

  static void _validatePathParameterRequired(Map<dynamic, dynamic> data, String inValue, String path) {
    // If in is "path", required MUST be true
    if (inValue == 'path') {
      if (!data.containsKey('required') || data['required'] != true) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'required'),
          'Parameter with in="path" MUST have required=true',
          specReference: 'OpenAPI 3.0.0 - Parameter Object',
        );
      }
    }
  }

  static void _validateOptionalFields(Map<dynamic, dynamic> data, String path, String inValue) {
    _validateRequiredField(data, path);
    _validateDescriptionField(data, path);
    _validateDeprecatedField(data, path);
    _validateAllowEmptyValueField(data, path, inValue);
    _validateStyleField(data, path);
    _validateExplodeField(data, path);
    _validateAllowReservedField(data, path, inValue);
  }

  static void _validateRequiredField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('required')) {
      ValidationUtils.requireBool(data['required'], ValidationUtils.buildPath(path, 'required'));
    }
  }

  static void _validateDescriptionField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('description')) {
      ValidationUtils.requireString(data['description'], ValidationUtils.buildPath(path, 'description'));
    }
  }

  static void _validateDeprecatedField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('deprecated')) {
      ValidationUtils.requireBool(data['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }
  }

  static void _validateAllowEmptyValueField(Map<dynamic, dynamic> data, String path, String inValue) {
    if (data.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(data['allowEmptyValue'], ValidationUtils.buildPath(path, 'allowEmptyValue'));
      // Only valid for query parameters
      if (inValue != 'query') {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'allowEmptyValue'),
          'allowEmptyValue is only valid for query parameters',
          specReference: 'OpenAPI 3.0.0 - Parameter Object',
        );
      }
    }
  }

  static void _validateStyleField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('style')) {
      final style = ValidationUtils.requireString(data['style'], ValidationUtils.buildPath(path, 'style'));
      const validStyles = [
        'matrix',
        'label',
        'form',
        'simple',
        'spaceDelimited',
        'pipeDelimited',
        'deepObject'
      ];
      ValidationUtils.validateEnum(style, validStyles, ValidationUtils.buildPath(path, 'style'));
    }
  }

  static void _validateExplodeField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('explode')) {
      ValidationUtils.requireBool(data['explode'], ValidationUtils.buildPath(path, 'explode'));
    }
  }

  static void _validateAllowReservedField(Map<dynamic, dynamic> data, String path, String inValue) {
    if (data.containsKey('allowReserved')) {
      ValidationUtils.requireBool(data['allowReserved'], ValidationUtils.buildPath(path, 'allowReserved'));
      if (inValue != 'query') {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'allowReserved'),
          'allowReserved is only valid for query parameters',
          specReference: 'OpenAPI 3.0.0 - Parameter Object',
        );
      }
    }
  }

  static void _validateSchemaOrContent(Map<dynamic, dynamic> data, String path) {
    final hasSchema = data.containsKey('schema');
    final hasContent = data.containsKey('content');

    if (!hasSchema && !hasContent) {
      throw OpenApiValidationException(
        path,
        'Parameter Object MUST contain either a schema property or a content property, but not both',
        specReference: 'OpenAPI 3.0.0 - Parameter Object',
      );
    }

    if (hasSchema && hasContent) {
      throw OpenApiValidationException(
        path,
        'Parameter Object MUST contain either a schema property or a content property, but not both',
        specReference: 'OpenAPI 3.0.0 - Parameter Object',
      );
    }

    if (hasSchema) {
      _validateSchemaField(data, path);
    }

    if (hasContent) {
      _validateContentField(data, path);
    }
  }

  static void _validateSchemaField(Map<dynamic, dynamic> data, String path) {
    final schema = ValidationUtils.requireMap(data['schema'], ValidationUtils.buildPath(path, 'schema'));
    SchemaObjectValidator.validate(schema, ValidationUtils.buildPath(path, 'schema'));
  }

  static void _validateContentField(Map<dynamic, dynamic> data, String path) {
    final content = ValidationUtils.requireMap(data['content'], ValidationUtils.buildPath(path, 'content'));
    // Content MUST contain exactly one entry
    if (content.length != 1) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'content'),
        'Parameter content map MUST contain exactly one entry',
        specReference: 'OpenAPI 3.0.0 - Parameter Object',
      );
    }
    // Media Type Object validation is handled separately
  }

  static void _validateExampleFields(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('example') && data.containsKey('examples')) {
      throw OpenApiValidationException(
        path,
        'Parameter Object cannot have both example and examples',
        specReference: 'OpenAPI 3.0.0 - Parameter Object',
      );
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      'name',
      'in',
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
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Parameter Object');
  }
}

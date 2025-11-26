import 'validation_exception.dart';
import 'validation_utils.dart';
import 'discriminator_object_validator.dart';

/// Validator for Schema Objects according to OpenAPI 3.0.0 specification.
/// The Schema Object is an extended subset of JSON Schema Specification Wright Draft 00.
class SchemaObjectValidator {
  /// Validates a Schema Object according to OpenAPI 3.0.0 specification.
  static void validate(Map<dynamic, dynamic> data, String path) {
    // Check if this is a reference
    if (data.containsKey(r'$ref')) {
      // If it's a reference, validate it as a Reference Object
      // (Reference validation is handled separately, but we check here for structure)
      return;
    }

    // Validate different sections
    _validateTypeField(data, path);
    _validateNumericConstraints(data, path);
    _validateStringConstraints(data, path);
    _validateArrayConstraints(data, path);
    _validateObjectConstraints(data, path);
    _validateCompositionKeywords(data, path);

    final enumValues = _validateEnumField(data, path);
    _validateOpenApiSpecificFields(data, path);

    final defaultValue = _validateDefaultValue(data, path);
    _validateDefaultAgainstEnum(defaultValue, enumValues, path);

    _validateDiscriminator(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateTypeField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('type')) {
      final type = ValidationUtils.requireString(data['type'], ValidationUtils.buildPath(path, 'type'));
      const validTypes = ['null', 'boolean', 'object', 'array', 'number', 'string', 'integer'];
      ValidationUtils.validateEnum(type, validTypes, ValidationUtils.buildPath(path, 'type'));

      // If type is "array", items MUST be present
      if (type == 'array') {
        _validateArrayItemsRequired(data, path);
      }
    }
  }

  static void _validateArrayItemsRequired(Map<dynamic, dynamic> data, String path) {
    if (!data.containsKey('items')) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'items'),
        'Schema with type "array" MUST have an "items" field',
        specReference: 'OpenAPI 3.0.0 - Schema Object',
      );
    }
    // items MUST be an object (not array in OpenAPI 3.0.0)
    final items = data['items'];
    if (items is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'items'),
        'Schema items MUST be an object, got ${items.runtimeType}',
        specReference: 'OpenAPI 3.0.0 - Schema Object',
      );
    }
    // Recursively validate items schema
    validate(items, ValidationUtils.buildPath(path, 'items'));
  }

  static void _validateNumericConstraints(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('multipleOf')) {
      final multipleOf = ValidationUtils.requireNumber(data['multipleOf'], ValidationUtils.buildPath(path, 'multipleOf'));
      ValidationUtils.validatePositive(multipleOf, ValidationUtils.buildPath(path, 'multipleOf'));
    }

    if (data.containsKey('maximum')) {
      ValidationUtils.requireNumber(data['maximum'], ValidationUtils.buildPath(path, 'maximum'));
    }

    if (data.containsKey('exclusiveMaximum')) {
      ValidationUtils.requireNumber(data['exclusiveMaximum'], ValidationUtils.buildPath(path, 'exclusiveMaximum'));
    }

    if (data.containsKey('minimum')) {
      ValidationUtils.requireNumber(data['minimum'], ValidationUtils.buildPath(path, 'minimum'));
    }

    if (data.containsKey('exclusiveMinimum')) {
      ValidationUtils.requireNumber(data['exclusiveMinimum'], ValidationUtils.buildPath(path, 'exclusiveMinimum'));
    }
  }

  static void _validateStringConstraints(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('maxLength')) {
      final maxLength = ValidationUtils.requireNumber(data['maxLength'], ValidationUtils.buildPath(path, 'maxLength'));
      ValidationUtils.validateNonNegative(maxLength, ValidationUtils.buildPath(path, 'maxLength'));
    }

    if (data.containsKey('minLength')) {
      final minLength = ValidationUtils.requireNumber(data['minLength'], ValidationUtils.buildPath(path, 'minLength'));
      ValidationUtils.validateNonNegative(minLength, ValidationUtils.buildPath(path, 'minLength'));
    }

    if (data.containsKey('pattern')) {
      ValidationUtils.requireString(data['pattern'], ValidationUtils.buildPath(path, 'pattern'));
      // Pattern should be a valid ECMA-262 regex (we validate it's a string, actual regex validation is complex)
    }
  }

  static void _validateArrayConstraints(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('maxItems')) {
      final maxItems = ValidationUtils.requireNumber(data['maxItems'], ValidationUtils.buildPath(path, 'maxItems'));
      ValidationUtils.validateNonNegative(maxItems, ValidationUtils.buildPath(path, 'maxItems'));
    }

    if (data.containsKey('minItems')) {
      final minItems = ValidationUtils.requireNumber(data['minItems'], ValidationUtils.buildPath(path, 'minItems'));
      ValidationUtils.validateNonNegative(minItems, ValidationUtils.buildPath(path, 'minItems'));
    }

    if (data.containsKey('uniqueItems')) {
      ValidationUtils.requireBool(data['uniqueItems'], ValidationUtils.buildPath(path, 'uniqueItems'));
    }
  }

  static void _validateObjectConstraints(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('maxProperties')) {
      final maxProperties = ValidationUtils.requireNumber(data['maxProperties'], ValidationUtils.buildPath(path, 'maxProperties'));
      ValidationUtils.validateNonNegative(maxProperties, ValidationUtils.buildPath(path, 'maxProperties'));
    }

    if (data.containsKey('minProperties')) {
      final minProperties = ValidationUtils.requireNumber(data['minProperties'], ValidationUtils.buildPath(path, 'minProperties'));
      ValidationUtils.validateNonNegative(minProperties, ValidationUtils.buildPath(path, 'minProperties'));
    }

    _validateRequiredField(data, path);
    _validatePropertiesField(data, path);
    _validateAdditionalPropertiesField(data, path);
  }

  static void _validateRequiredField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('required')) {
      final required = ValidationUtils.requireList(data['required'], ValidationUtils.buildPath(path, 'required'));
      // Each element must be a string
      for (var i = 0; i < required.length; i++) {
        ValidationUtils.requireString(required[i], ValidationUtils.buildPath(path, 'required[$i]'));
      }
      // Elements must be unique
      final requiredSet = required.map((e) => e.toString()).toSet();
      if (requiredSet.length != required.length) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'required'),
          'Required array must contain unique strings',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
    }
  }

  static void _validatePropertiesField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('properties')) {
      final properties = ValidationUtils.requireMap(data['properties'], ValidationUtils.buildPath(path, 'properties'));
      for (final key in properties.keys) {
        final keyStr = key.toString();
        final propertySchema = properties[key];
        if (propertySchema is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'properties.$keyStr'),
            'Property schema must be an object',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        validate(propertySchema, ValidationUtils.buildPath(path, 'properties.$keyStr'));
      }
    }
  }

  static void _validateAdditionalPropertiesField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('additionalProperties')) {
      final additionalProperties = data['additionalProperties'];
      if (additionalProperties is! bool && additionalProperties is! Map) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'additionalProperties'),
          'additionalProperties must be boolean or Schema Object',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
      if (additionalProperties is Map) {
        validate(additionalProperties, ValidationUtils.buildPath(path, 'additionalProperties'));
      }
    }
  }

  static void _validateCompositionKeywords(Map<dynamic, dynamic> data, String path) {
    const compositionKeywords = ['allOf', 'oneOf', 'anyOf'];
    for (final keyword in compositionKeywords) {
      _validateCompositionKeyword(data, path, keyword);
    }

    _validateNotKeyword(data, path);
  }

  static void _validateCompositionKeyword(Map<dynamic, dynamic> data, String path, String keyword) {
    if (data.containsKey(keyword)) {
      final schemas = ValidationUtils.requireList(data[keyword], ValidationUtils.buildPath(path, keyword));
      if (schemas.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, keyword),
          '$keyword array must contain at least one schema',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
      for (var i = 0; i < schemas.length; i++) {
        final schema = schemas[i];
        if (schema is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, '$keyword[$i]'),
            'Schema must be an object',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        validate(schema, ValidationUtils.buildPath(path, '$keyword[$i]'));
      }
    }
  }

  static void _validateNotKeyword(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('not')) {
      final notSchema = data['not'];
      if (notSchema is! Map) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'not'),
          'not must be a Schema Object',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
      validate(notSchema, ValidationUtils.buildPath(path, 'not'));
    }
  }

  static List<dynamic>? _validateEnumField(Map<dynamic, dynamic> data, String path) {
    List<dynamic>? enumValues;
    if (data.containsKey('enum')) {
      enumValues = ValidationUtils.requireList(data['enum'], ValidationUtils.buildPath(path, 'enum'));
      if (enumValues.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'enum'),
          'enum array must contain at least one element',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
    }
    return enumValues;
  }

  static void _validateOpenApiSpecificFields(Map<dynamic, dynamic> data, String path) {
    _validateNullableField(data, path);
    _validateReadOnlyWriteOnlyFields(data, path);
    _validateDeprecatedField(data, path);
    _validateFormatField(data, path);
  }

  static void _validateNullableField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('nullable')) {
      ValidationUtils.requireBool(data['nullable'], ValidationUtils.buildPath(path, 'nullable'));
    }
  }

  static void _validateReadOnlyWriteOnlyFields(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('readOnly')) {
      ValidationUtils.requireBool(data['readOnly'], ValidationUtils.buildPath(path, 'readOnly'));
    }

    if (data.containsKey('writeOnly')) {
      ValidationUtils.requireBool(data['writeOnly'], ValidationUtils.buildPath(path, 'writeOnly'));
    }

    // readOnly and writeOnly cannot both be true
    if (data.containsKey('readOnly') && data.containsKey('writeOnly')) {
      if (data['readOnly'] == true && data['writeOnly'] == true) {
        throw OpenApiValidationException(
          path,
          'readOnly and writeOnly cannot both be true',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
    }
  }

  static void _validateDeprecatedField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('deprecated')) {
      ValidationUtils.requireBool(data['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }
  }

  static void _validateFormatField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('format')) {
      ValidationUtils.requireString(data['format'], ValidationUtils.buildPath(path, 'format'));
      // Format is open string-valued, so we just validate it's a string
    }
  }

  static dynamic _validateDefaultValue(Map<dynamic, dynamic> data, String path) {
    dynamic defaultValue;
    if (data.containsKey('default')) {
      defaultValue = data['default'];

      if (data.containsKey('type')) {
        _validateDefaultValueType(defaultValue, data['type'] as String, path);
      }
    }
    return defaultValue;
  }

  static void _validateDefaultValueType(dynamic defaultValue, String type, String path) {
    switch (type) {
      case 'string':
        if (defaultValue is! String) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'default'),
            'Default value must be a string when type is string',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        break;
      case 'integer':
      case 'number':
        if (defaultValue is! num) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'default'),
            'Default value must be a number when type is $type',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        break;
      case 'boolean':
        if (defaultValue is! bool) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'default'),
            'Default value must be a boolean when type is boolean',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        break;
      case 'array':
        if (defaultValue is! List) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'default'),
            'Default value must be an array when type is array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        break;
      case 'object':
        if (defaultValue is! Map) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'default'),
            'Default value must be an object when type is object',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        break;
    }
  }

  static void _validateDefaultAgainstEnum(dynamic defaultValue, List<dynamic>? enumValues, String path) {
    if (enumValues != null && defaultValue != null) {
      bool found = false;
      for (final enumValue in enumValues) {
        // Use deep equality check for complex types, value equality for primitives
        if (_valuesEqual(defaultValue, enumValue)) {
          found = true;
          break;
        }
      }

      if (!found) {
        final enumStr = enumValues.map((v) => v.toString()).join(', ');
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'default'),
          'Default value "$defaultValue" is not one of the enum values: [$enumStr]',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
    }
  }

  static void _validateDiscriminator(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('discriminator')) {
      final discriminator = data['discriminator'];
      if (discriminator is! Map) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'discriminator'),
          'discriminator must be a Discriminator Object',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
      DiscriminatorObjectValidator.validate(discriminator, ValidationUtils.buildPath(path, 'discriminator'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      // JSON Schema fields
      'title',
      'multipleOf',
      'maximum',
      'exclusiveMaximum',
      'minimum',
      'exclusiveMinimum',
      'maxLength',
      'minLength',
      'pattern',
      'maxItems',
      'minItems',
      'uniqueItems',
      'maxProperties',
      'minProperties',
      'required',
      'enum',
      'type',
      'allOf',
      'oneOf',
      'anyOf',
      'not',
      'items',
      'properties',
      'additionalProperties',
      'description',
      'format',
      'default',
      // OpenAPI-specific fields
      'nullable',
      'discriminator',
      'readOnly',
      'writeOnly',
      'xml',
      'externalDocs',
      'example',
      'deprecated',
      // Reference
      r'$ref',
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Schema Object');
  }

  static bool _valuesEqual(dynamic a, dynamic b) {
    // Direct equality check
    if (a == b) return true;

    // Handle numeric type conversions (int vs double vs num)
    if (a is num && b is num) {
      if (a is int && b is int) {
        return a == b;
      } else if (a is double && b is double) {
        return a == b;
      } else {
        // Cross-type numeric comparison
        return a.toDouble() == b.toDouble();
      }
    }

    // For other types, use standard equality
    return false;
  }
}


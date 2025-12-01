import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';
import 'discriminator_object_structural_validator.dart';

/// Structural validator for Schema Objects (OpenAPI 3.0.0).
/// Validates structure, types, and allowed keywords only.
/// Semantic validation (logic, consistency) is handled in Stage 3.
class SchemaObjectStructuralValidator {
  /// Validates the structural correctness of a Schema Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    // Check if this is a reference
    if (data.containsKey(r'$ref')) {
      // If it's a reference, only structural validation is needed
      return;
    }

    // Validate different sections
    _validateTypeField(data, path);
    _validateNumericConstraints(data, path);
    _validateStringConstraints(data, path);
    _validateArrayConstraints(data, path);
    _validateObjectConstraints(data, path);
    _validateCompositionKeywords(data, path);
    _validateEnumField(data, path);
    _validateDefaultField(data, path);
    _validateOpenApiSpecificFields(data, path);
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
        severity: ValidationSeverity.critical,
      );
    }
    // items MUST be an object (not array in OpenAPI 3.0.0)
    final items = data['items'];
    if (items is! Map) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'items'),
        'Schema items MUST be an object, got ${items.runtimeType}',
        specReference: 'OpenAPI 3.0.0 - Schema Object',
        severity: ValidationSeverity.critical,
      );
    }
    // Recursively validate items schema
    validate(items, ValidationUtils.buildPath(path, 'items'));
  }

  static void _validateNumericConstraints(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('multipleOf')) {
      final multipleOf = ValidationUtils.requireNumber(
        data['multipleOf'],
        ValidationUtils.buildPath(path, 'multipleOf'),
      );
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
      final maxProperties = ValidationUtils.requireNumber(
        data['maxProperties'],
        ValidationUtils.buildPath(path, 'maxProperties'),
      );
      ValidationUtils.validateNonNegative(maxProperties, ValidationUtils.buildPath(path, 'maxProperties'));
    }

    if (data.containsKey('minProperties')) {
      final minProperties = ValidationUtils.requireNumber(
        data['minProperties'],
        ValidationUtils.buildPath(path, 'minProperties'),
      );
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
            severity: ValidationSeverity.critical,
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
          severity: ValidationSeverity.critical,
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

      // Per JSON Schema Core spec: value MUST be a non-empty array
      if (schemas.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, keyword),
          '$keyword array MUST contain at least one schema',
          specReference: 'JSON Schema Core - Section 10.2.1',
          severity: ValidationSeverity.critical,
        );
      }

      // Validate each schema in the array
      for (var i = 0; i < schemas.length; i++) {
        final schema = schemas[i];
        final itemPath = ValidationUtils.buildPath(path, '$keyword[$i]');

        if (schema is! Map) {
          throw OpenApiValidationException(
            itemPath,
            'Each item in $keyword array MUST be a Schema Object or Reference Object',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
            severity: ValidationSeverity.critical,
          );
        }

        // Recursively validate the schema
        validate(schema, itemPath);
      }
    }
  }

  static void _validateNotKeyword(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('not')) {
      final notSchema = data['not'];
      final notPath = ValidationUtils.buildPath(path, 'not');

      if (notSchema is! Map) {
        throw OpenApiValidationException(
          notPath,
          'not keyword\'s value MUST be a Schema Object',
          specReference: 'JSON Schema Core - Section 10.2.1.4',
          severity: ValidationSeverity.critical,
        );
      }

      // Recursively validate the schema
      validate(notSchema, notPath);
    }
  }

  static void _validateEnumField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('enum')) {
      final enumValues = ValidationUtils.requireList(data['enum'], ValidationUtils.buildPath(path, 'enum'));
      if (enumValues.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'enum'),
          'enum array cannot be empty',
          specReference: 'JSON Schema Validation - Section 6.1.2',
          severity: ValidationSeverity.critical,
        );
      }
    }
  }

  static void _validateDefaultField(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('default')) {
      // Default can be any type - just check it exists
      // Semantic validation will check if it matches the schema's type
    }
  }

  static void _validateOpenApiSpecificFields(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('nullable')) {
      ValidationUtils.requireBool(data['nullable'], ValidationUtils.buildPath(path, 'nullable'));
    }

    if (data.containsKey('readOnly')) {
      ValidationUtils.requireBool(data['readOnly'], ValidationUtils.buildPath(path, 'readOnly'));
    }

    if (data.containsKey('writeOnly')) {
      ValidationUtils.requireBool(data['writeOnly'], ValidationUtils.buildPath(path, 'writeOnly'));
    }

    if (data.containsKey('deprecated')) {
      ValidationUtils.requireBool(data['deprecated'], ValidationUtils.buildPath(path, 'deprecated'));
    }

    if (data.containsKey('xml')) {
      ValidationUtils.requireMap(data['xml'], ValidationUtils.buildPath(path, 'xml'));
    }

    if (data.containsKey('externalDocs')) {
      ValidationUtils.requireMap(data['externalDocs'], ValidationUtils.buildPath(path, 'externalDocs'));
    }
  }

  static void _validateDiscriminator(Map<dynamic, dynamic> data, String path) {
    if (data.containsKey('discriminator')) {
      final discriminator = ValidationUtils.requireMap(data['discriminator'], ValidationUtils.buildPath(path, 'discriminator'));
      DiscriminatorObjectStructuralValidator.validate(discriminator, ValidationUtils.buildPath(path, 'discriminator'));
    }
  }

  static void _validateAllowedFields(Map<dynamic, dynamic> data, String path) {
    const allowedFields = {
      // Core JSON Schema keywords
      'type', 'properties', 'items', 'required', 'enum', 'const',
      'multipleOf', 'maximum', 'exclusiveMaximum', 'minimum', 'exclusiveMinimum',
      'maxLength', 'minLength', 'pattern',
      'maxItems', 'minItems', 'uniqueItems',
      'maxProperties', 'minProperties',
      'additionalProperties',
      'allOf', 'oneOf', 'anyOf', 'not',
      'format', 'default',
      // Metadata keywords
      'title', 'description', 'example',
      // OpenAPI-specific
      'nullable', 'discriminator', 'readOnly', 'writeOnly',
      'xml', 'externalDocs', 'deprecated',
    };
    ValidationUtils.validateNoUnknownFields(data, allowedFields, path, 'Schema Object');
  }
}


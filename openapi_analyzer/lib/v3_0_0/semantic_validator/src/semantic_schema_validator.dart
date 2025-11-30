import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Semantic validator for Schema Objects (OpenAPI 3.0.0).
/// Validates logical consistency and meaningful relationships.
class SemanticSchemaValidator {
  /// Validates semantic correctness of a Schema Object.
  static void validate(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
    // Skip references - they're validated elsewhere
    if (data.containsKey(r'$ref')) {
      return;
    }

    // Validate composition semantics
    if (data.containsKey('allOf')) {
      _validateAllOfSemantics(data['allOf'], path, document);
    }
    if (data.containsKey('oneOf')) {
      _validateOneOfSemantics(data['oneOf'], path);
    }
    if (data.containsKey('anyOf')) {
      _validateAnyOfSemantics(data['anyOf'], path);
    }

    // Validate discriminator semantics
    if (data.containsKey('discriminator')) {
      _validateDiscriminatorSemantics(data, path, document);
    }

    // Validate default value against enum
    if (data.containsKey('default') && data.containsKey('enum')) {
      _validateDefaultAgainstEnum(data['default'], data['enum'], path);
    }

    // Validate numeric constraints logic
    _validateNumericConstraintsLogic(data, path);

    // Validate string constraints logic
    _validateStringConstraintsLogic(data, path);

    // Validate array constraints logic
    _validateArrayConstraintsLogic(data, path);

    // Validate object constraints logic
    _validateObjectConstraintsLogic(data, path);

    // Recursively validate nested schemas
    _validateNestedSchemas(data, path, document);
  }

  static void _validateAllOfSemantics(List<dynamic> schemas, String path, Map<dynamic, dynamic>? document) {
    // Check for duplicate references
    final refs = <String>[];
    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i] is Map && (schemas[i] as Map).containsKey(r'$ref')) {
        final ref = (schemas[i] as Map)[r'$ref'] as String;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'allOf'),
            'Duplicate reference "$ref" found in allOf array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }
    }

    // Additional semantic checks for allOf would go here
    // (e.g., checking for incompatible types, enum conflicts, etc.)
  }

  static void _validateOneOfSemantics(List<dynamic> schemas, String path) {
    // Check for duplicate references
    final refs = <String>[];
    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i] is Map && (schemas[i] as Map).containsKey(r'$ref')) {
        final ref = (schemas[i] as Map)[r'$ref'] as String;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'oneOf'),
            'Duplicate reference "$ref" found in oneOf array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }
    }
  }

  static void _validateAnyOfSemantics(List<dynamic> schemas, String path) {
    // Check for duplicate references
    final refs = <String>[];
    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i] is Map && (schemas[i] as Map).containsKey(r'$ref')) {
        final ref = (schemas[i] as Map)[r'$ref'] as String;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'anyOf'),
            'Duplicate reference "$ref" found in anyOf array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }
    }
  }

  static void _validateDiscriminatorSemantics(Map<dynamic, dynamic> data, String path, Map<dynamic, dynamic>? document) {
    final discriminator = data['discriminator'] as Map;
    final propertyName = discriminator['propertyName'] as String;

    // Check if the discriminator property exists in the schema or its composition
    final hasProperty = _hasPropertyInSchema(data, propertyName);
    
    if (!hasProperty) {
      // This might be valid if it's inherited, but flag it as potentially problematic
      // More sophisticated validation would check inheritance chains
    }

    // Additional discriminator validation would go here
  }

  static bool _hasPropertyInSchema(Map<dynamic, dynamic> schema, String propertyName) {
    if (schema.containsKey('properties') && schema['properties'] is Map) {
      final properties = schema['properties'] as Map;
      if (properties.containsKey(propertyName)) {
        return true;
      }
    }

    // Check in allOf
    if (schema.containsKey('allOf') && schema['allOf'] is List) {
      final allOf = schema['allOf'] as List;
      for (final item in allOf) {
        if (item is Map && _hasPropertyInSchema(item, propertyName)) {
          return true;
        }
      }
    }

    return false;
  }

  static void _validateDefaultAgainstEnum(dynamic defaultValue, dynamic enumValues, String path) {
    if (enumValues is! List) {
      return;
    }

    if (!enumValues.contains(defaultValue)) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, 'default'),
        'Default value is not one of the enum values',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  static void _validateNumericConstraintsLogic(Map<dynamic, dynamic> data, String path) {
    // Check minimum <= maximum
    if (data.containsKey('minimum') && data.containsKey('maximum')) {
      final minimum = data['minimum'] as num;
      final maximum = data['maximum'] as num;
      if (minimum > maximum) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'minimum'),
          'minimum ($minimum) cannot be greater than maximum ($maximum)',
          specReference: 'JSON Schema Validation',
        );
      }
    }

    // Check exclusiveMinimum < exclusiveMaximum
    if (data.containsKey('exclusiveMinimum') && data.containsKey('exclusiveMaximum')) {
      final exclusiveMinimum = data['exclusiveMinimum'] as num;
      final exclusiveMaximum = data['exclusiveMaximum'] as num;
      if (exclusiveMinimum >= exclusiveMaximum) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'exclusiveMinimum'),
          'exclusiveMinimum ($exclusiveMinimum) must be less than exclusiveMaximum ($exclusiveMaximum)',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  static void _validateStringConstraintsLogic(Map<dynamic, dynamic> data, String path) {
    // Check minLength <= maxLength
    if (data.containsKey('minLength') && data.containsKey('maxLength')) {
      final minLength = data['minLength'] as num;
      final maxLength = data['maxLength'] as num;
      if (minLength > maxLength) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'minLength'),
          'minLength ($minLength) cannot be greater than maxLength ($maxLength)',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  static void _validateArrayConstraintsLogic(Map<dynamic, dynamic> data, String path) {
    // Check minItems <= maxItems
    if (data.containsKey('minItems') && data.containsKey('maxItems')) {
      final minItems = data['minItems'] as num;
      final maxItems = data['maxItems'] as num;
      if (minItems > maxItems) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'minItems'),
          'minItems ($minItems) cannot be greater than maxItems ($maxItems)',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  static void _validateObjectConstraintsLogic(Map<dynamic, dynamic> data, String path) {
    // Check minProperties <= maxProperties
    if (data.containsKey('minProperties') && data.containsKey('maxProperties')) {
      final minProperties = data['minProperties'] as num;
      final maxProperties = data['maxProperties'] as num;
      if (minProperties > maxProperties) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'minProperties'),
          'minProperties ($minProperties) cannot be greater than maxProperties ($maxProperties)',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  static void _validateNestedSchemas(Map<dynamic, dynamic> data, String path, Map<dynamic, dynamic>? document) {
    // Recursively validate properties
    if (data.containsKey('properties') && data['properties'] is Map) {
      final properties = data['properties'] as Map;
      for (final entry in properties.entries) {
        final propName = entry.key.toString();
        final propSchema = entry.value;
        if (propSchema is Map) {
          validate(propSchema, ValidationUtils.buildPath(path, 'properties.$propName'), document: document);
        }
      }
    }

    // Recursively validate items
    if (data.containsKey('items') && data['items'] is Map) {
      validate(data['items'], ValidationUtils.buildPath(path, 'items'), document: document);
    }

    // Recursively validate additionalProperties
    if (data.containsKey('additionalProperties') && data['additionalProperties'] is Map) {
      validate(data['additionalProperties'], ValidationUtils.buildPath(path, 'additionalProperties'), document: document);
    }

    // Recursively validate composition schemas
    for (final keyword in ['allOf', 'oneOf', 'anyOf']) {
      if (data.containsKey(keyword) && data[keyword] is List) {
        final schemas = data[keyword] as List;
        for (var i = 0; i < schemas.length; i++) {
          if (schemas[i] is Map) {
            validate(schemas[i], ValidationUtils.buildPath(path, '$keyword[$i]'), document: document);
          }
        }
      }
    }

    // Recursively validate not
    if (data.containsKey('not') && data['not'] is Map) {
      validate(data['not'], ValidationUtils.buildPath(path, 'not'), document: document);
    }
  }
}


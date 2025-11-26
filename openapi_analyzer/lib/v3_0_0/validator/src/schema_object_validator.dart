import 'validation_exception.dart';
import 'validation_utils.dart';
import 'discriminator_object_validator.dart';

/// Validator for Schema Objects according to OpenAPI 3.0.0 specification.
/// The Schema Object is an extended subset of JSON Schema Specification Wright Draft 00.
class SchemaObjectValidator {
  /// Validates a Schema Object according to OpenAPI 3.0.0 specification.
  ///
  /// [document] is the full OpenAPI document, used for resolving internal references
  /// during semantic validation. If not provided, reference resolution is skipped.
  static void validate(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
    // Check if this is a reference
    if (data.containsKey(r'$ref')) {
      // If it's a reference, validate it as a Reference Object
      // (Reference validation is handled separately, but we check here for structure)
      return;
    }

    // Validate different sections
    _validateTypeField(data, path, document: document);
    _validateNumericConstraints(data, path);
    _validateStringConstraints(data, path);
    _validateArrayConstraints(data, path);
    _validateObjectConstraints(data, path, document: document);
    _validateCompositionKeywords(data, path, document: document);

    final enumValues = _validateEnumField(data, path);
    _validateOpenApiSpecificFields(data, path);

    final defaultValue = _validateDefaultValue(data, path);
    _validateDefaultAgainstEnum(defaultValue, enumValues, path);

    _validateDiscriminator(data, path);
    _validateAllowedFields(data, path);
  }

  static void _validateTypeField(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
    if (data.containsKey('type')) {
      final type = ValidationUtils.requireString(data['type'], ValidationUtils.buildPath(path, 'type'));
      const validTypes = ['null', 'boolean', 'object', 'array', 'number', 'string', 'integer'];
      ValidationUtils.validateEnum(type, validTypes, ValidationUtils.buildPath(path, 'type'));

      // If type is "array", items MUST be present
      if (type == 'array') {
        _validateArrayItemsRequired(data, path, document: document);
      }
    }
  }

  static void _validateArrayItemsRequired(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
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
    validate(items, ValidationUtils.buildPath(path, 'items'), document: document);
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

  static void _validateObjectConstraints(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
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
    _validatePropertiesField(data, path, document: document);
    _validateAdditionalPropertiesField(data, path, document: document);
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

  static void _validatePropertiesField(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
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
        validate(propertySchema, ValidationUtils.buildPath(path, 'properties.$keyStr'), document: document);
      }
    }
  }

  static void _validateAdditionalPropertiesField(
    Map<dynamic, dynamic> data,
    String path, {
    Map<dynamic, dynamic>? document,
  }) {
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
        validate(additionalProperties, ValidationUtils.buildPath(path, 'additionalProperties'), document: document);
      }
    }
  }

  static void _validateCompositionKeywords(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
    const compositionKeywords = ['allOf', 'oneOf', 'anyOf'];
    for (final keyword in compositionKeywords) {
      _validateCompositionKeyword(data, path, keyword, document: document);
    }

    _validateNotKeyword(data, path, document: document);
  }

  static void _validateCompositionKeyword(
    Map<dynamic, dynamic> data,
    String path,
    String keyword, {
    Map<dynamic, dynamic>? document,
  }) {
    if (data.containsKey(keyword)) {
      final schemas = ValidationUtils.requireList(data[keyword], ValidationUtils.buildPath(path, keyword));

      // Per JSON Schema Core spec: value MUST be a non-empty array
      if (schemas.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, keyword),
          '$keyword array MUST contain at least one schema. Per JSON Schema Core, this keyword\'s value MUST be a non-empty array.',
          specReference: 'JSON Schema Core - Section 10.2.1 (allOf/anyOf/oneOf)',
        );
      }

      // Validate each schema in the array
      for (var i = 0; i < schemas.length; i++) {
        final schema = schemas[i];
        final itemPath = ValidationUtils.buildPath(path, '$keyword[$i]');

        // Per JSON Schema Core: Each item of the array MUST be a valid JSON Schema
        // Per OpenAPI 3.0.0: Must be a Schema Object (not a standard JSON Schema)
        if (schema is! Map) {
          throw OpenApiValidationException(
            itemPath,
            'Each item in $keyword array MUST be a Schema Object (or Reference Object with \$ref), got ${schema.runtimeType}',
            specReference: 'OpenAPI 3.0.0 - Schema Object / JSON Schema Core - Section 10.2.1',
          );
        }

        // Validate the schema is well-formed
        _validateCompositionSchema(schema, itemPath, keyword);

        // Recursively validate the schema
        validate(schema, itemPath, document: document);
      }

      // Additional validation: check for semantic issues
      _validateCompositionSemantics(schemas, path, keyword, document: document);
    }
  }

  /// Validates that a schema within a composition keyword is well-formed
  static void _validateCompositionSchema(Map<dynamic, dynamic> schema, String path, String keyword) {
    // A schema should either be a reference OR have schema properties, not a mix in invalid ways
    final hasRef = schema.containsKey(r'$ref');

    if (hasRef) {
      final ref = schema[r'$ref'];
      if (ref is! String || ref.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, r'$ref'),
          '\$ref in $keyword schema must be a non-empty string',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
        );
      }

      // In OpenAPI 3.0.0, when $ref is used, it should be standalone
      // (siblings are ignored per spec, but we can warn about common mistakes)
      if (schema.length > 1) {
        // Note: This is a lenient check - OpenAPI 3.0 ignores sibling keywords,
        // but their presence might indicate user error
        // We'll allow it but could add a warning system in the future
      }
    } else {
      // It's an inline schema - ensure it has at least some schema properties or is an empty schema
      // An empty object {} is a valid schema that accepts anything
      if (schema.isEmpty) {
        // Empty schema is valid - accepts any instance
        return;
      }

      // Validate it has valid schema properties (this will be checked in the recursive validate call)
      // but we can do a basic sanity check here
      final hasSchemaKeywords = schema.keys.any(
        (key) =>
            key == 'type' ||
            key == 'properties' ||
            key == 'items' ||
            key == 'allOf' ||
            key == 'oneOf' ||
            key == 'anyOf' ||
            key == 'not' ||
            key == 'enum' ||
            key == 'const' ||
            key == 'required' ||
            key == 'description' ||
            key == 'title' ||
            key == 'default' ||
            key == 'format' ||
            key == 'pattern' ||
            key == 'minimum' ||
            key == 'maximum' ||
            key == 'exclusiveMinimum' ||
            key == 'exclusiveMaximum' ||
            key == 'minLength' ||
            key == 'maxLength' ||
            key == 'minItems' ||
            key == 'maxItems' ||
            key == 'minProperties' ||
            key == 'maxProperties' ||
            key == 'multipleOf' ||
            key == 'uniqueItems' ||
            key == 'additionalProperties' ||
            key == 'nullable' ||
            key == 'discriminator' ||
            key == 'readOnly' ||
            key == 'writeOnly' ||
            key == 'xml' ||
            key == 'externalDocs' ||
            key == 'example' ||
            key == 'deprecated',
      );

      if (!hasSchemaKeywords) {
        // Schema has properties but none are recognized schema keywords
        // This might be okay if it's an extension, but it's suspicious
        // The recursive validate call will catch any truly invalid fields
      }
    }
  }

  /// Validates semantic rules for composition keywords
  static void _validateCompositionSemantics(
    List<dynamic> schemas,
    String path,
    String keyword, {
    Map<dynamic, dynamic>? document,
  }) {
    // Check for duplicate references
    final refs = <String>[];
    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i] is Map && (schemas[i] as Map).containsKey(r'$ref')) {
        final ref = (schemas[i] as Map)[r'$ref'] as String;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, keyword),
            'Duplicate reference "$ref" found in $keyword array. The same schema is referenced multiple times, which is redundant.',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }
    }

    // For oneOf specifically, warn about potential ambiguity
    if (keyword == 'oneOf' && schemas.length < 2) {
      // While technically valid, oneOf with one schema is pointless
      // It's the same as just using that schema directly
      // We'll allow it but it's semantically odd
    }

    // Check for contradictory schemas in allOf
    if (keyword == 'allOf') {
      _validateAllOfSemantics(schemas, path, document: document);
    }
  }

  /// Validates semantic rules specific to allOf
  static void _validateAllOfSemantics(List<dynamic> schemas, String path, {Map<dynamic, dynamic>? document}) {
    // Check for obvious contradictions (e.g., different const values)
    final constValues = <dynamic>[];
    final enumValues = <List<dynamic>>[];
    final types = <String>[];

    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i] is Map) {
        Map schema = schemas[i] as Map;

        // Try to resolve reference if document is provided
        if (schema.containsKey(r'$ref') && document != null) {
          final ref = schema[r'$ref'] as String;
          final resolvedSchema = _resolveInternalReference(ref, document);
          if (resolvedSchema != null) {
            schema = resolvedSchema;
          }
        }

        // Collect const values
        if (schema.containsKey('const')) {
          constValues.add(schema['const']);
        }

        // Collect enum values
        if (schema.containsKey('enum') && schema['enum'] is List) {
          enumValues.add(schema['enum'] as List<dynamic>);
        }

        // Collect types
        if (schema.containsKey('type') && schema['type'] is String) {
          types.add(schema['type'] as String);
        }
      }
    }

    // Check for multiple different const values (impossible to satisfy)
    if (constValues.length > 1) {
      final uniqueConsts = <dynamic>{};
      for (final constVal in constValues) {
        uniqueConsts.add(constVal);
      }
      if (uniqueConsts.length > 1) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'allOf'),
          'allOf contains schemas with different const values (${constValues.join(", ")}). This schema can never be satisfied.',
          specReference: 'JSON Schema Core - Section 10.2.1.1 (allOf)',
        );
      }
    }

    // Check for incompatible types (excluding null which can be combined with nullable)
    if (types.length > 1) {
      final uniqueTypes = types.toSet();
      // Different non-compatible types
      if (uniqueTypes.length > 1) {
        // Some type combinations are impossible
        final incompatibleTypes = {'string', 'number', 'integer', 'boolean', 'array', 'object'};
        final foundIncompatibleTypes = uniqueTypes.intersection(incompatibleTypes);
        if (foundIncompatibleTypes.length > 1) {
          throw OpenApiValidationException(
            ValidationUtils.buildPath(path, 'allOf'),
            'allOf contains schemas with incompatible types (${types.join(", ")}). An instance cannot simultaneously be of multiple incompatible types.',
            specReference: 'JSON Schema Core - Section 10.2.1.1 (allOf)',
          );
        }
      }
    }

    // Check for disjoint enum values
    if (enumValues.length > 1) {
      // Find intersection of all enum arrays
      Set<dynamic> intersection = enumValues[0].toSet();
      for (var i = 1; i < enumValues.length; i++) {
        intersection = intersection.intersection(enumValues[i].toSet());
      }
      if (intersection.isEmpty) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'allOf'),
          'allOf contains schemas with disjoint enum values. There is no common value that satisfies all enum constraints.',
          specReference: 'JSON Schema Core - Section 10.2.1.1 (allOf)',
        );
      }
    }
  }

  static void _validateNotKeyword(Map<dynamic, dynamic> data, String path, {Map<dynamic, dynamic>? document}) {
    if (data.containsKey('not')) {
      final notSchema = data['not'];
      final notPath = ValidationUtils.buildPath(path, 'not');

      // Per JSON Schema Core: value MUST be a valid JSON Schema
      if (notSchema is! Map) {
        throw OpenApiValidationException(
          notPath,
          'not keyword\'s value MUST be a Schema Object, got ${notSchema.runtimeType}',
          specReference: 'JSON Schema Core - Section 10.2.1.4 (not) / OpenAPI 3.0.0 - Schema Object',
        );
      }

      // Validate the schema is well-formed
      _validateCompositionSchema(notSchema, notPath, 'not');

      // Recursively validate the schema
      validate(notSchema, notPath, document: document);

      // Semantic check: 'not' with an empty schema (which matches everything) means nothing matches
      if (notSchema.isEmpty) {
        // not: {} means the instance must NOT validate against an empty schema
        // Since empty schema accepts everything, not: {} rejects everything
        // This is technically valid but semantically creates an impossible-to-satisfy schema
        // We'll allow it but it's worth noting
      }
    }
  }

  /// Resolves an internal JSON Pointer reference like "#/components/schemas/Pet"
  /// Returns the resolved schema or null if the reference can't be resolved.
  /// Only handles internal references (starting with #/), not external file references.
  static Map<dynamic, dynamic>? _resolveInternalReference(String ref, Map<dynamic, dynamic> document) {
    // Only handle internal references
    if (!ref.startsWith('#/')) {
      return null;
    }

    // Remove the leading '#/'
    final pointer = ref.substring(2);
    if (pointer.isEmpty) {
      return document;
    }

    // Split the pointer into parts
    final parts = pointer.split('/');
    dynamic current = document;

    // Navigate through the document
    for (final part in parts) {
      // Decode JSON Pointer escaping
      final decodedPart = part.replaceAll('~1', '/').replaceAll('~0', '~');

      if (current is Map) {
        if (!current.containsKey(decodedPart)) {
          // Reference not found
          return null;
        }
        current = current[decodedPart];
      } else {
        // Can't navigate further
        return null;
      }
    }

    // Return the resolved object if it's a Map
    return current is Map ? current : null;
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

      // Per OpenAPI 3.0.0 spec: discriminator is legal only when using oneOf, anyOf, or allOf
      final hasCompositionKeyword = data.containsKey('oneOf') || data.containsKey('anyOf') || data.containsKey('allOf');

      if (!hasCompositionKeyword) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, 'discriminator'),
          'discriminator is only legal when used with one of the composite keywords: oneOf, anyOf, or allOf',
          specReference: 'OpenAPI 3.0.0 - Discriminator Object',
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

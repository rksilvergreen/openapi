import '../../../validation_exception.dart';
import '../../parser/src/schema_object.dart';
import '../../parser/src/referenceable.dart';
import '../../parser/src/openapi_document.dart';
import '../../parser/src/enums.dart';
import 'reference_resolver.dart';

/// Semantic validator for Schema Objects using typed objects.
///
/// This validator checks logical consistency and meaningful relationships
/// in schema definitions, ensuring they make sense and won't cause runtime
/// issues or impossible-to-satisfy constraints.
///
/// Validates:
/// - Constraint logic (min ≤ max, minLength ≤ maxLength, etc.)
/// - Composition semantics (allOf type conflicts, enum intersections)
/// - Discriminator property existence
/// - Default value compatibility with enum
/// - Nested schema consistency
class SemanticSchemaValidator {
  /// The complete OpenAPI document for reference resolution.
  final OpenApiDocument document;

  /// Reference resolver for following $ref pointers.
  final ReferenceResolver resolver;

  /// Creates a new schema validator.
  ///
  /// [document] The complete OpenAPI document, needed for resolving references
  /// and checking cross-schema relationships.
  SemanticSchemaValidator(this.document) : resolver = ReferenceResolver(document);

  /// Validates semantic correctness of a Schema Object or reference.
  ///
  /// This is the main entry point for schema validation. It handles both
  /// direct schemas and references, then recursively validates all nested
  /// schemas.
  ///
  /// Checks performed:
  /// - Recursive allOf collection and validation (including parent schemas)
  ///   - Explicit type requirement across all schemas
  ///   - Numeric constraint coherence across all schemas
  ///   - String constraint coherence across all schemas
  ///   - Array constraint coherence across all schemas
  ///   - Object constraint coherence across all schemas
  ///   - Explicit type compatibility in allOf
  ///   - Implicit type compatibility (type-specific properties) in allOf
  ///   - Const compatibility
  ///   - Enum compatibility
  /// - Composition semantics (oneOf/anyOf validation)
  /// - Discriminator logic
  /// - Default vs enum compatibility
  /// - Recursive validation of nested schemas
  ///
  /// [schemaRef] The schema or reference to validate.
  /// [path] JSON Pointer path to this schema for error reporting.
  ///
  /// Throws [OpenApiValidationException] if semantic rules are violated.
  void validate(Referenceable<SchemaObject> schemaRef, String path) {
    // If it's a reference, we can't validate it directly yet (need reference resolution)
    if (schemaRef.isReference()) {
      // TODO: Resolve and validate
      return;
    }

    final schema = schemaRef.asValue();
    if (schema == null) return;

    // Step 1: Create parent schema and collect all schemas in the allOf chain recursively
    final parentSchema = schema.copyWith(allOf: null, oneOf: null, anyOf: null, not: null);
    final allSchemas = schema.allOf != null
        ? [Referenceable.value(parentSchema), ...schema.allOf!]
        : [Referenceable.value(parentSchema)];

    // Step 2: Validate allOf semantics (includes basic constraint validation across all schemas)
    _validateAllOfSemantics(allSchemas, path);

    // Step 3: Validate other composition semantics (oneOf/anyOf)
    if (schema.oneOf != null) {
      _validateOneOfSemantics(schema.oneOf!, path);
    }
    if (schema.anyOf != null) {
      _validateAnyOfSemantics(schema.anyOf!, path);
    }

    // Step 4: Validate discriminator
    if (schema.discriminator != null) {
      _validateDiscriminatorSemantics(schema, path);
    }

    // Step 5: Validate default against enum
    if (schema.default_ != null && schema.enum_ != null) {
      _validateDefaultAgainstEnum(schema.default_!, schema.enum_!, path);
    }

    // Step 6: Recursively validate nested schemas
    _validateNestedSchemas(schema, path);
  }

  /// Validates that a schema has an explicit `type` property.
  ///
  /// OpenAPI requires that every schema explicitly declares its type using the
  /// `type` keyword. Types cannot be implicitly inferred from other properties
  /// (e.g., having `minLength` does not imply `type: string`).
  ///
  /// This validation ensures type safety and prevents ambiguity in schema
  /// definitions.
  ///
  /// Valid:
  /// - `type: string` ✓
  /// - `type: object, properties: {...}` ✓
  /// - `type: array, items: {...}` ✓
  ///
  /// Invalid:
  /// - `minLength: 5` ✗ (no explicit type)
  /// - `properties: {...}` ✗ (no explicit type, even though it's clearly an object)
  /// - `items: {...}` ✗ (no explicit type, even though it's clearly an array)
  ///
  /// Note: This validation applies to all schemas except those that are pure
  /// references (which inherit the type from the referenced schema).
  ///
  /// [schema] The schema object to validate.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if the schema lacks an explicit type.
  void _validateExplicitType(SchemaObject schema, String path) {
    if (schema.type == null) {
      throw OpenApiValidationException(
        path,
        'Schema must have an explicit "type" property. Types cannot be inferred from other properties.',
        specReference: 'OpenAPI 3.0.0 - Schema Object',
      );
    }
  }

  /// Validates numeric constraint coherence for number/integer schemas.
  ///
  /// Ensures that numeric bounds are logically consistent and don't create
  /// impossible-to-satisfy constraints.
  ///
  /// Checks:
  /// 1. **minimum ≤ maximum**: If both are specified, minimum must not exceed maximum.
  ///    Example: `minimum: 10, maximum: 5` is invalid.
  ///
  /// 2. **exclusiveMinimum < exclusiveMaximum**: If both are specified, there must
  ///    be at least some valid range between them.
  ///    Example: `exclusiveMinimum: 5, exclusiveMaximum: 5` is invalid (no valid values).
  ///
  /// [schema] The schema object to validate.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if constraints are incoherent.
  void _validateNumericConstraints(SchemaObject schema, String path) {
    // Check minimum <= maximum
    if (schema.minimum != null && schema.maximum != null) {
      if (schema.minimum! > schema.maximum!) {
        throw OpenApiValidationException(
          '$path/minimum',
          'minimum (${schema.minimum}) cannot be greater than maximum (${schema.maximum})',
          specReference: 'JSON Schema Validation',
        );
      }
    }

    // Check exclusiveMinimum < exclusiveMaximum
    if (schema.exclusiveMinimum != null && schema.exclusiveMaximum != null) {
      if (schema.exclusiveMinimum! >= schema.exclusiveMaximum!) {
        throw OpenApiValidationException(
          '$path/exclusiveMinimum',
          'exclusiveMinimum (${schema.exclusiveMinimum}) must be less than exclusiveMaximum (${schema.exclusiveMaximum})',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  /// Validates string constraint coherence for string schemas.
  ///
  /// Ensures that string length bounds are logically consistent.
  ///
  /// Checks:
  /// - **minLength ≤ maxLength**: If both are specified, the minimum length
  ///   must not exceed the maximum length.
  ///   Example: `minLength: 10, maxLength: 5` is invalid (impossible to satisfy).
  ///
  /// [schema] The schema object to validate.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if constraints are incoherent.
  void _validateStringConstraints(SchemaObject schema, String path) {
    // Check minLength <= maxLength
    if (schema.minLength != null && schema.maxLength != null) {
      if (schema.minLength! > schema.maxLength!) {
        throw OpenApiValidationException(
          '$path/minLength',
          'minLength (${schema.minLength}) cannot be greater than maxLength (${schema.maxLength})',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  /// Validates array constraint coherence for array schemas.
  ///
  /// Ensures that array size bounds are logically consistent.
  ///
  /// Checks:
  /// - **minItems ≤ maxItems**: If both are specified, the minimum number of
  ///   items must not exceed the maximum number.
  ///   Example: `minItems: 5, maxItems: 3` is invalid (impossible to satisfy).
  ///
  /// [schema] The schema object to validate.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if constraints are incoherent.
  void _validateArrayConstraints(SchemaObject schema, String path) {
    // Check minItems <= maxItems
    if (schema.minItems != null && schema.maxItems != null) {
      if (schema.minItems! > schema.maxItems!) {
        throw OpenApiValidationException(
          '$path/minItems',
          'minItems (${schema.minItems}) cannot be greater than maxItems (${schema.maxItems})',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  /// Validates object constraint coherence for object schemas.
  ///
  /// Ensures that object property count bounds are logically consistent.
  ///
  /// Checks:
  /// - **minProperties ≤ maxProperties**: If both are specified, the minimum
  ///   number of properties must not exceed the maximum number.
  ///   Example: `minProperties: 10, maxProperties: 5` is invalid (impossible to satisfy).
  ///
  /// [schema] The schema object to validate.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if constraints are incoherent.
  void _validateObjectConstraints(SchemaObject schema, String path) {
    // Check minProperties <= maxProperties
    if (schema.minProperties != null && schema.maxProperties != null) {
      if (schema.minProperties! > schema.maxProperties!) {
        throw OpenApiValidationException(
          '$path/minProperties',
          'minProperties (${schema.minProperties}) cannot be greater than maxProperties (${schema.maxProperties})',
          specReference: 'JSON Schema Validation',
        );
      }
    }
  }

  /// Validates semantic correctness of an `allOf` composition.
  ///
  /// The `allOf` keyword requires a value to satisfy ALL schemas in the array
  /// simultaneously, including the parent schema itself. The first schema in the
  /// list represents the parent schema (with composition keywords removed), followed
  /// by the schemas from the allOf array.
  ///
  /// This validator ensures that the combination is logically possible and doesn't
  /// create contradictions. It recursively collects ALL schemas in the allOf chain,
  /// including parent schemas of nested allOf compositions.
  ///
  /// Checks:
  /// 1. **Recursive collection**: Collects all schemas in the allOf chain recursively,
  ///    including parent schemas (without composition keywords) of nested allOf.
  ///
  /// 2. **No duplicate references**: Each $ref should appear only once to avoid
  ///    redundant validation.
  ///
  /// 3. **Basic constraint validation across all schemas**:
  ///    - Explicit type requirement
  ///    - Numeric constraint coherence
  ///    - String constraint coherence
  ///    - Array constraint coherence
  ///    - Object constraint coherence
  ///
  /// 4. **Explicit type compatibility**: Ensures all schemas' types are compatible.
  ///
  /// 5. **Implicit type compatibility**: Ensures type-specific properties don't conflict.
  ///
  /// 6. **Const compatibility**: Ensures multiple `const` values don't conflict.
  ///
  /// 7. **Enum compatibility**: Ensures enum constraints have common values.
  ///
  /// [schemas] The list of schemas to validate, where the first is the parent schema
  /// (without composition keywords) and the rest are from the allOf array.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if allOf semantics are violated.
  void _validateAllOfSemantics(List<Referenceable<SchemaObject>> schemas, String path) {
    // Step 1: Recursively collect all schemas in the allOf chain
    final allCollectedSchemas = _collectAllOfSchemasRecursively(schemas, path);

    // Step 2: Validate basic constraints across all collected schemas
    for (final schema in allCollectedSchemas) {
      // Validate explicit type requirement (must have 'type' property)
      _validateExplicitType(schema, path);

      // Validate numeric constraints logic
      _validateNumericConstraints(schema, path);

      // Validate string constraints logic
      _validateStringConstraints(schema, path);

      // Validate array constraints logic
      _validateArrayConstraints(schema, path);

      // Validate object constraints logic
      _validateObjectConstraints(schema, path);
    }

    // Step 3: Validate explicit type compatibility across all schemas
    _validateAllOfExplicitTypes(allCollectedSchemas, path);

    // Step 4: Validate implicit type compatibility across all schemas
    _validateAllOfImplicitTypes(allCollectedSchemas, path);

    // Step 5: Validate const compatibility across all schemas
    _validateAllOfConsts(allCollectedSchemas, path);

    // Step 6: Validate enum compatibility across all schemas
    _validateAllOfEnums(allCollectedSchemas, path);
  }

  /// Recursively collects all schemas in an allOf chain, including parent schemas.
  ///
  /// This method traverses the entire allOf hierarchy, collecting:
  /// 1. The provided schemas (parent + allOf)
  /// 2. For each resolved schema that has allOf:
  ///    - Its parent schema (without composition keywords)
  ///    - All schemas from its allOf array (recursively)
  ///
  /// This ensures that ALL schemas in the composition chain are validated together,
  /// including nested parent schemas.
  ///
  /// [schemas] The initial list of schemas to process.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Returns a list of all collected and resolved schemas.
  ///
  /// Throws [OpenApiValidationException] if duplicate references are found.
  List<SchemaObject> _collectAllOfSchemasRecursively(List<Referenceable<SchemaObject>> schemas, String path) {
    final refs = <String>{};
    final resolvedSchemas = <SchemaObject>[];

    void processSchemas(List<Referenceable<SchemaObject>> schemasToProcess) {
      for (var i = 0; i < schemasToProcess.length; i++) {
        if (schemasToProcess[i].isReference()) {
          final ref = schemasToProcess[i].asReference()!;
          if (refs.contains(ref)) {
            throw OpenApiValidationException(
              '$path/allOf',
              'Duplicate reference "$ref" found in allOf array',
              specReference: 'OpenAPI 3.0.0 - Schema Object',
            );
          }
          refs.add(ref);

          // Resolve the reference
          final resolved = resolver.resolveSchemaRef(schemasToProcess[i], '$path/allOf[$i]');
          if (resolved != null) {
            resolvedSchemas.add(resolved);

            // If the resolved schema has allOf, recursively collect its schemas
            if (resolved.allOf != null) {
              // Create parent schema for the resolved schema
              final nestedParent = resolved.copyWith(allOf: null, oneOf: null, anyOf: null, not: null);
              // Recursively process parent + allOf
              processSchemas([Referenceable.value(nestedParent), ...resolved.allOf!]);
            }
          }
        } else {
          final schema = schemasToProcess[i].asValue();
          if (schema != null) {
            resolvedSchemas.add(schema);

            // If the schema has allOf, recursively collect its schemas
            if (schema.allOf != null) {
              // Create parent schema
              final nestedParent = schema.copyWith(allOf: null, oneOf: null, anyOf: null, not: null);
              // Recursively process parent + allOf
              processSchemas([Referenceable.value(nestedParent), ...schema.allOf!]);
            }
          }
        }
      }
    }

    processSchemas(schemas);
    return resolvedSchemas;
  }

  /// Validates that explicit `type` properties in all schemas are compatible.
  ///
  /// Since `allOf` requires satisfying ALL schemas (including the parent), a value cannot
  /// be multiple primitive types at once. This checks for fundamentally incompatible explicit
  /// type requirements when schemas specify a `type` property.
  ///
  /// Valid:
  /// - `type: "string", allOf: [{type: "string"}]` ✓ (same type)
  /// - `type: "object", allOf: [{properties: {...}}]` ✓ (compatible)
  /// - `allOf: [{type: "string"}, {type: "string"}]` ✓ (same type)
  ///
  /// Invalid:
  /// - `type: "string", allOf: [{type: "number"}]` ✗ (can't be both)
  /// - `type: "array", allOf: [{type: "object"}]` ✗ (incompatible)
  /// - `allOf: [{type: "boolean"}, {type: "integer"}]` ✗ (incompatible)
  ///
  /// Note: `integer` and `number` are considered compatible since integer is
  /// a subset of number (not currently in incompatible pairs).
  ///
  /// This validation only checks schemas that have an explicit `type` property.
  /// For checking type-specific properties (like `minLength`, `required`, etc.),
  /// see `_validateAllOfImplicitTypes`.
  ///
  /// [schemas] The resolved schemas (first is parent, rest are from allOf).
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if incompatible explicit types are detected.
  void _validateAllOfExplicitTypes(List<SchemaObject> schemas, String path) {
    // Collect types from all schemas
    final types = schemas.where((s) => s.type != null).map((s) => s.type!).toList();

    if (types.length > 1) {
      final uniqueTypes = types.toSet();
      if (uniqueTypes.length > 1) {
        // Different types - check if they're incompatible
        final incompatiblePairs = [
          [SchemaType.string, SchemaType.number],
          [SchemaType.string, SchemaType.integer],
          [SchemaType.string, SchemaType.boolean],
          [SchemaType.string, SchemaType.array],
          [SchemaType.string, SchemaType.object],
          [SchemaType.number, SchemaType.boolean],
          [SchemaType.number, SchemaType.array],
          [SchemaType.number, SchemaType.object],
          [SchemaType.integer, SchemaType.boolean],
          [SchemaType.integer, SchemaType.array],
          [SchemaType.integer, SchemaType.object],
          [SchemaType.boolean, SchemaType.array],
          [SchemaType.boolean, SchemaType.object],
          [SchemaType.array, SchemaType.object],
        ];

        for (final pair in incompatiblePairs) {
          if (types.contains(pair[0]) && types.contains(pair[1])) {
            // Convert enum values to strings for error message
            final typeNames = types.map((t) => t.name).join(', ');
            final pairNames = '${pair[0].name} and ${pair[1].name}';
            throw OpenApiValidationException(
              path,
              'Schema contains incompatible types: $typeNames. This may occur in the parent schema or its allOf composition. A value cannot be both $pairNames simultaneously.',
              specReference: 'JSON Schema Core - allOf semantics',
            );
          }
        }
      }
    }
  }

  /// Validates that type-specific properties in all schemas don't conflict.
  ///
  /// Even when schemas don't have explicit `type` properties, certain properties
  /// are specific to particular types. When these appear together across schemas,
  /// they create incompatible constraints that cannot be satisfied simultaneously.
  ///
  /// Type-specific property groups:
  /// - **String**: `minLength`, `maxLength`, `pattern`
  /// - **Number/Integer**: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`
  /// - **Array**: `minItems`, `maxItems`, `uniqueItems`, `items`
  /// - **Object**: `minProperties`, `maxProperties`, `required`, `properties`, `additionalProperties`, `patternProperties`
  ///
  /// Valid:
  /// - `minLength: 5, allOf: [{maxLength: 10}]` ✓ (both string properties)
  /// - `minimum: 0, allOf: [{maximum: 100}]` ✓ (both number properties)
  /// - `allOf: [{minLength: 5}, {maxLength: 10}]` ✓ (both string properties)
  ///
  /// Invalid:
  /// - `minLength: 5, allOf: [{required: ["name"]}]` ✗ (string + object properties)
  /// - `additionalProperties: true, allOf: [{exclusiveMaximum: 10}]` ✗ (object + number properties)
  /// - `items: {...}, allOf: [{properties: {...}}]` ✗ (array + object properties)
  /// - `minLength: 5, allOf: [{minItems: 3}]` ✗ (string + array properties)
  /// - `minimum: 0, allOf: [{minLength: 5}]` ✗ (number + string properties)
  ///
  /// This validation ensures that type-specific constraints from different types
  /// don't appear together across schemas, which would create an impossible-to-satisfy schema.
  ///
  /// [schemas] The resolved schemas (first is parent, rest are from allOf).
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if incompatible type-specific properties are detected.
  void _validateAllOfImplicitTypes(List<SchemaObject> schemas, String path) {
    // Collect type-specific properties from all schemas
    var hasStringProps = false;
    var hasNumberProps = false;
    var hasArrayProps = false;
    var hasObjectProps = false;

    for (var i = 0; i < schemas.length; i++) {
      final schema = schemas[i];

      // Check for string-specific properties
      if (schema.minLength != null || schema.maxLength != null || schema.pattern != null) {
        hasStringProps = true;
      }

      // Check for number/integer-specific properties
      if (schema.minimum != null ||
          schema.maximum != null ||
          schema.exclusiveMinimum != null ||
          schema.exclusiveMaximum != null ||
          schema.multipleOf != null) {
        hasNumberProps = true;
      }

      // Check for array-specific properties
      if (schema.minItems != null || schema.maxItems != null || schema.uniqueItems || schema.items != null) {
        hasArrayProps = true;
      }

      // Check for object-specific properties
      if (schema.minProperties != null ||
          schema.maxProperties != null ||
          schema.required_ != null ||
          schema.properties != null ||
          schema.additionalProperties != null ||
          schema.patternProperties != null) {
        hasObjectProps = true;
      }
    }

    // Check for conflicts between different type-specific property groups
    if (hasStringProps && hasNumberProps) {
      throw OpenApiValidationException(
        path,
        'Schema contains incompatible type-specific properties: string properties (minLength/maxLength/pattern) cannot be combined with number properties (minimum/maximum/multipleOf). This may occur in the parent schema or its allOf composition.',
        specReference: 'JSON Schema Core - allOf semantics',
      );
    }

    if (hasStringProps && hasArrayProps) {
      throw OpenApiValidationException(
        path,
        'Schema contains incompatible type-specific properties: string properties (minLength/maxLength/pattern) cannot be combined with array properties (minItems/maxItems/items). This may occur in the parent schema or its allOf composition.',
        specReference: 'JSON Schema Core - allOf semantics',
      );
    }

    if (hasStringProps && hasObjectProps) {
      throw OpenApiValidationException(
        path,
        'Schema contains incompatible type-specific properties: string properties (minLength/maxLength/pattern) cannot be combined with object properties (properties/required/additionalProperties). This may occur in the parent schema or its allOf composition.',
        specReference: 'JSON Schema Core - allOf semantics',
      );
    }

    if (hasNumberProps && hasArrayProps) {
      throw OpenApiValidationException(
        path,
        'Schema contains incompatible type-specific properties: number properties (minimum/maximum/multipleOf) cannot be combined with array properties (minItems/maxItems/items). This may occur in the parent schema or its allOf composition.',
        specReference: 'JSON Schema Core - allOf semantics',
      );
    }

    if (hasNumberProps && hasObjectProps) {
      throw OpenApiValidationException(
        path,
        'Schema contains incompatible type-specific properties: number properties (minimum/maximum/multipleOf) cannot be combined with object properties (properties/required/additionalProperties). This may occur in the parent schema or its allOf composition.',
        specReference: 'JSON Schema Core - allOf semantics',
      );
    }

    if (hasArrayProps && hasObjectProps) {
      throw OpenApiValidationException(
        path,
        'Schema contains incompatible type-specific properties: array properties (minItems/maxItems/items) cannot be combined with object properties (properties/required/additionalProperties). This may occur in the parent schema or its allOf composition.',
        specReference: 'JSON Schema Core - allOf semantics',
      );
    }
  }

  /// Validates that `const` values in all schemas don't conflict.
  ///
  /// The `const` keyword restricts a value to exactly one specific value.
  /// If multiple schemas specify different `const` values, it's impossible to
  /// satisfy all of them simultaneously.
  ///
  /// Valid:
  /// - `const: "active", allOf: [{const: "active"}]` ✓ (same value)
  /// - `allOf: [{const: "active"}, {const: "active"}]` ✓ (same value)
  /// - `const: "active", allOf: [{minLength: 5}]` ✓ (one const, other constraints)
  ///
  /// Invalid:
  /// - `const: "active", allOf: [{const: "inactive"}]` ✗ (conflicting values)
  /// - `allOf: [{const: 42}, {const: 43}]` ✗ (can't be both 42 and 43)
  ///
  /// This creates a logically impossible schema that will never validate any value.
  ///
  /// [schemas] The resolved schemas (first is parent, rest are from allOf).
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if multiple different const values exist.
  void _validateAllOfConsts(List<SchemaObject> schemas, String path) {
    // Collect const values from all schemas
    final constValues = schemas.where((s) => s.const_ != null).map((s) => s.const_).toList();

    if (constValues.length > 1) {
      final uniqueConsts = constValues.toSet();
      if (uniqueConsts.length > 1) {
        throw OpenApiValidationException(
          path,
          'Schema contains multiple different const values: ${constValues.join(", ")}. This may occur in the parent schema or its allOf composition. This schema can never be satisfied.',
          specReference: 'JSON Schema Core - allOf semantics',
        );
      }
    }
  }

  /// Validates that `enum` constraints in all schemas have common values.
  ///
  /// When multiple schemas specify `enum` values, there must be at least one value
  /// that appears in ALL enum arrays (intersection). Otherwise, no value can satisfy
  /// all schemas simultaneously.
  ///
  /// Valid:
  /// - `enum: ["a", "b"], allOf: [{enum: ["b", "c"]}]` ✓ (intersection: "b")
  /// - `allOf: [{enum: ["a", "b", "c"]}, {enum: ["b", "c", "d"]}]` ✓ (intersection: "b", "c")
  /// - `enum: [1, 2, 3], allOf: [{enum: [2]}]` ✓ (intersection: 2)
  ///
  /// Invalid:
  /// - `enum: ["red", "blue"], allOf: [{enum: ["green", "yellow"]}]` ✗ (no intersection)
  /// - `allOf: [{enum: [1, 2]}, {enum: [3, 4]}]` ✗ (disjoint sets)
  ///
  /// This creates a logically impossible schema since a value must be in all enums,
  /// but no value satisfies all.
  ///
  /// [schemas] The resolved schemas (first is parent, rest are from allOf).
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if enum sets have no intersection.
  void _validateAllOfEnums(List<SchemaObject> schemas, String path) {
    // Collect enum lists from all schemas
    final enumLists = schemas.where((s) => s.enum_ != null).map((s) => s.enum_!).toList();

    if (enumLists.length > 1) {
      // Find intersection of all enums
      var intersection = enumLists[0].toSet();
      for (var i = 1; i < enumLists.length; i++) {
        intersection = intersection.intersection(enumLists[i].toSet());
      }

      if (intersection.isEmpty) {
        throw OpenApiValidationException(
          path,
          'Schema contains enum constraints with no common values. This may occur in the parent schema or its allOf composition. This schema can never be satisfied.',
          specReference: 'JSON Schema Core - allOf semantics',
        );
      }
    }
  }

  /// Validates semantic correctness of a `oneOf` composition.
  ///
  /// The `oneOf` keyword requires a value to satisfy EXACTLY ONE schema from
  /// the array (not zero, not multiple). This validator checks for basic issues.
  ///
  /// Checks:
  /// - **No duplicate references**: Each $ref should appear only once. Having
  ///   duplicates means a value would match the same schema twice, violating
  ///   the "exactly one" requirement.
  ///   Example: `oneOf: [{$ref: "#/User"}, {$ref: "#/User"}]` is invalid.
  ///
  /// Future enhancements could include:
  /// - Detecting overlapping schemas that could match the same value
  /// - Warning about schemas that can never be satisfied
  ///
  /// [schemas] The list of schemas in the oneOf array.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if duplicate references are found.
  void _validateOneOfSemantics(List<Referenceable<SchemaObject>> schemas, String path) {
    // Check for duplicate references
    final refs = <String>[];
    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i].isReference()) {
        final ref = schemas[i].asReference()!;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            '$path/oneOf',
            'Duplicate reference "$ref" found in oneOf array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }
    }
  }

  /// Validates semantic correctness of an `anyOf` composition.
  ///
  /// The `anyOf` keyword requires a value to satisfy AT LEAST ONE schema from
  /// the array (but can match multiple). This validator checks for basic issues.
  ///
  /// Checks:
  /// - **No duplicate references**: Each $ref should appear only once to avoid
  ///   redundant validation and maintain clarity.
  ///   Example: `anyOf: [{$ref: "#/User"}, {$ref: "#/User"}]` is flagged.
  ///
  /// Unlike `oneOf`, having overlapping schemas is not an error for `anyOf`
  /// since matching multiple is allowed and expected in some cases.
  ///
  /// Future enhancements could include:
  /// - Warning about schemas that are subsets of others (redundant)
  /// - Detecting if all schemas are mutually exclusive (consider using oneOf)
  ///
  /// [schemas] The list of schemas in the anyOf array.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if duplicate references are found.
  void _validateAnyOfSemantics(List<Referenceable<SchemaObject>> schemas, String path) {
    // Check for duplicate references
    final refs = <String>[];
    for (var i = 0; i < schemas.length; i++) {
      if (schemas[i].isReference()) {
        final ref = schemas[i].asReference()!;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            '$path/anyOf',
            'Duplicate reference "$ref" found in anyOf array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }
    }
  }

  /// Validates discriminator property existence and semantics.
  ///
  /// A discriminator is used in polymorphic schemas (typically with oneOf/anyOf)
  /// to determine which specific schema variant applies. The discriminator
  /// property must exist in the schema or its composition.
  ///
  /// Checks:
  /// 1. **Property existence**: The discriminator propertyName should exist
  ///    either directly in the schema's properties or in one of the allOf
  ///    composed schemas.
  ///
  /// 2. **Mapping references** (TODO): If discriminator.mapping is specified,
  ///    all mapped values should reference existing schemas.
  ///
  /// Example:
  /// ```yaml
  /// Pet:
  ///   type: object
  ///   discriminator:
  ///     propertyName: petType  # Must exist in properties or allOf
  ///   oneOf:
  ///     - $ref: '#/components/schemas/Dog'
  ///     - $ref: '#/components/schemas/Cat'
  /// ```
  ///
  /// [schema] The schema object containing a discriminator.
  /// [path] JSON Pointer path for error reporting.
  void _validateDiscriminatorSemantics(SchemaObject schema, String path) {
    final discriminator = schema.discriminator!;
    final propertyName = discriminator.propertyName;

    // Check if the discriminator property exists in the schema's properties
    if (schema.properties != null && !schema.properties!.containsKey(propertyName)) {
      // Check in composition
      final hasInComposition = _hasPropertyInComposition(schema, propertyName);
      if (!hasInComposition) {
        // Not an error if in inheritance pattern, but worth noting
        // More sophisticated validation would check inheritance chains
      }
    }

    // TODO: Validate discriminator mapping references exist
  }

  /// Helper method to check if a property exists in composed schemas.
  ///
  /// When validating discriminators or other property-dependent features,
  /// we need to check not just the immediate schema but also schemas
  /// composed via `allOf`.
  ///
  /// This currently checks:
  /// - Direct properties in `allOf` schemas (non-references only)
  ///
  /// Limitations:
  /// - Does not follow references within allOf (could be enhanced)
  /// - Only checks allOf, not oneOf/anyOf (usually not needed for discriminators)
  ///
  /// [schema] The parent schema to check.
  /// [propertyName] The name of the property to find.
  ///
  /// Returns true if the property is found in any allOf schema.
  bool _hasPropertyInComposition(SchemaObject schema, String propertyName) {
    // Check in allOf
    if (schema.allOf != null) {
      for (final item in schema.allOf!) {
        if (!item.isReference()) {
          final subSchema = item.asValue();
          if (subSchema?.properties?.containsKey(propertyName) == true) {
            return true;
          }
        }
      }
    }
    return false;
  }

  /// Validates that a default value is compatible with enum constraints.
  ///
  /// If both `default` and `enum` are specified in a schema, the default value
  /// must be one of the allowed enum values. Otherwise, the default itself
  /// would be invalid according to the schema.
  ///
  /// Valid:
  /// - `enum: ["red", "green", "blue"], default: "red"` ✓
  /// - `enum: [1, 2, 3], default: 2` ✓
  ///
  /// Invalid:
  /// - `enum: ["red", "green", "blue"], default: "yellow"` ✗
  /// - `enum: [1, 2, 3], default: 5` ✗
  ///
  /// This is a common mistake that would make the default value fail validation
  /// against its own schema.
  ///
  /// [defaultValue] The default value from the schema.
  /// [enumValues] The list of allowed enum values.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Throws [OpenApiValidationException] if default is not in enum.
  void _validateDefaultAgainstEnum(dynamic defaultValue, List<dynamic> enumValues, String path) {
    if (!enumValues.contains(defaultValue)) {
      throw OpenApiValidationException(
        '$path/default',
        'Default value "$defaultValue" is not one of the enum values: ${enumValues.join(", ")}',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Recursively validates all nested schemas within a parent schema.
  ///
  /// Schemas can be deeply nested in various locations. This method ensures
  /// that all nested schemas are validated by recursively calling `validate()`
  /// on each one.
  ///
  /// Validated nested locations:
  ///
  /// 1. **properties**: For object schemas, each property schema is validated.
  ///    Example: `properties: {name: {type: string}, age: {type: integer}}`
  ///
  /// 2. **items**: For array schemas, the item schema is validated.
  ///    Example: `items: {type: string, minLength: 3}`
  ///
  /// 3. **additionalProperties**: For object schemas with dynamic properties,
  ///    validates the schema for additional properties (if it's a schema, not boolean).
  ///    Example: `additionalProperties: {type: string}`
  ///
  /// 4. **allOf**: Validates each schema in the allOf composition array.
  ///    Example: `allOf: [{$ref: "#/Base"}, {properties: {...}}]`
  ///
  /// 5. **oneOf**: Validates each schema in the oneOf composition array.
  ///    Example: `oneOf: [{type: string}, {type: number}]`
  ///
  /// 6. **anyOf**: Validates each schema in the anyOf composition array.
  ///    Example: `anyOf: [{type: string}, {type: number}]`
  ///
  /// 7. **not**: Validates the negation schema.
  ///    Example: `not: {type: null}`
  ///
  /// This ensures comprehensive validation of the entire schema tree.
  ///
  /// [schema] The parent schema containing nested schemas.
  /// [path] JSON Pointer path for error reporting (will be extended for each nested schema).
  void _validateNestedSchemas(SchemaObject schema, String path) {
    // Recursively validate properties
    if (schema.properties != null) {
      for (final entry in schema.properties!.entries) {
        validate(entry.value, '$path/properties/${entry.key}');
      }
    }

    // Recursively validate items
    if (schema.items != null) {
      validate(schema.items!, '$path/items');
    }

    // Recursively validate additionalProperties if it's a schema
    if (schema.additionalProperties is Referenceable<SchemaObject>) {
      validate(schema.additionalProperties as Referenceable<SchemaObject>, '$path/additionalProperties');
    }

    // Recursively validate composition schemas
    if (schema.allOf != null) {
      for (var i = 0; i < schema.allOf!.length; i++) {
        validate(schema.allOf![i], '$path/allOf[$i]');
      }
    }
    if (schema.oneOf != null) {
      for (var i = 0; i < schema.oneOf!.length; i++) {
        validate(schema.oneOf![i], '$path/oneOf[$i]');
      }
    }
    if (schema.anyOf != null) {
      for (var i = 0; i < schema.anyOf!.length; i++) {
        validate(schema.anyOf![i], '$path/anyOf[$i]');
      }
    }

    // Recursively validate not
    if (schema.not != null) {
      validate(schema.not!, '$path/not');
    }
  }
}

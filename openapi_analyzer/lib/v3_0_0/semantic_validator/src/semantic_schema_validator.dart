import '../../../validation_exception.dart';
import '../../parser/src/schema_object.dart';
import '../../parser/src/referenceable.dart';
import '../../parser/src/openapi_document.dart';
import '../../parser/src/enums.dart';
import 'reference_resolver.dart';

/// Semantic validator for Schema Objects using typed objects.
///
/// This validator uses a branch-based approach to handle schema composition:
/// - oneOf/anyOf creates separate validation branches
/// - allOf accumulates schemas along each branch (including parent schema)
/// - Each branch is validated independently for type and constraint compatibility
///
/// Validates:
/// - Constraint logic (min ≤ max, minLength ≤ maxLength, etc.)
/// - Composition semantics (branch-based type conflicts, enum intersections)
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
  /// This is the main entry point for schema validation using a branch-based approach.
  /// It handles both direct schemas and references, enumerates all possible branches
  /// created by oneOf/anyOf compositions, and validates each branch independently.
  ///
  /// Validation process:
  /// 1. Enumerate all branches (paths through oneOf/anyOf choices)
  /// 2. For each branch, validate accumulated schemas:
  ///    - Explicit type requirement
  ///    - Numeric/string/array/object constraint coherence
  ///    - Type compatibility (explicit and implicit)
  ///    - Const and enum compatibility
  /// 3. Validate discriminator semantics
  /// 4. Validate default vs enum compatibility
  /// 5. Recursively validate nested schemas
  ///
  /// [schemaRef] The schema or reference to validate.
  /// [path] JSON Pointer path to this schema for error reporting.
  ///
  /// Throws [OpenApiValidationException] if semantic rules are violated.
  void validate(Referenceable<SchemaObject> schemaRef, String path) {
    // If it's a reference, resolve it first
    SchemaObject? schema;
    if (schemaRef.isReference()) {
      schema = resolver.resolveSchemaRef(schemaRef, path);
      if (schema == null) return;
    } else {
      schema = schemaRef.asValue();
      if (schema == null) return;
    }

    // Step 1: Enumerate all branches
    final branches = _enumerateBranches(schema, path);

    // Step 2: Validate each branch independently
    for (final branch in branches) {
      _validateBranch(branch);
    }

    // Step 3: Validate discriminator
    if (schema.discriminator != null) {
      _validateDiscriminatorSemantics(schema, path);
    }

    // Step 4: Validate default against enum
    if (schema.default_ != null && schema.enum_ != null) {
      _validateDefaultAgainstEnum(schema.default_!, schema.enum_!, path);
    }

    // Step 5: Recursively validate nested schemas
    _validateNestedSchemas(schema, path);
  }

  /// Enumerates all possible branches in a schema's composition structure.
  ///
  /// A branch represents one possible path through the schema tree, determined
  /// by choices in oneOf/anyOf compositions. Each branch accumulates all schemas
  /// via allOf (including parent schemas) along its path.
  ///
  /// Process:
  /// 1. Create parent schema (without composition keywords)
  /// 2. Collect all allOf schemas for the current level
  /// 3. If oneOf/anyOf exists, recursively enumerate branches for each option
  /// 4. If no oneOf/anyOf, return single branch with accumulated schemas
  ///
  /// Example:
  /// ```yaml
  /// type: object
  /// allOf: [{type: string}]
  /// oneOf:
  ///   - type: number
  ///   - oneOf:
  ///     - type: integer
  ///     - type: boolean
  /// ```
  /// Creates 3 branches:
  /// - [{parent}, {type: string}, {type: number}]
  /// - [{parent}, {type: string}, {}, {type: integer}]
  /// - [{parent}, {type: string}, {}, {type: boolean}]
  ///
  /// [schema] The schema to enumerate branches from.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Returns a list of branches, each containing accumulated schemas.
  ///
  /// Throws [OpenApiValidationException] for duplicate references in oneOf/anyOf.
  List<_SchemaBranch> _enumerateBranches(SchemaObject schema, String path) {
    // Step 1: Create parent schema (without composition keywords)
    final parent = schema.copyWith(allOf: null, oneOf: null, anyOf: null, not: null);

    // Step 2: Collect all allOf schemas at this level
    final allOfSchemas = <SchemaObject>[parent];
    if (schema.allOf != null) {
      for (var i = 0; i < schema.allOf!.length; i++) {
        final allOfItem = schema.allOf![i];
        final resolved = _resolveAndGetSchema(allOfItem, '$path/allOf[$i]');
        if (resolved != null) {
          allOfSchemas.add(resolved);
        }
      }
    }

    // Step 3: Check for oneOf or anyOf
    final oneOfOrAnyOf = schema.oneOf ?? schema.anyOf;

    if (oneOfOrAnyOf == null) {
      // No branching - return single branch with all accumulated schemas
      return [_SchemaBranch(allOfSchemas, path)];
    }

    // Step 4: Enumerate branches for each oneOf/anyOf option
    final compositionType = schema.oneOf != null ? 'oneOf' : 'anyOf';
    final refs = <String>{};
    final branches = <_SchemaBranch>[];

    for (var i = 0; i < oneOfOrAnyOf.length; i++) {
      final item = oneOfOrAnyOf[i];

      // Check for duplicate references
      if (item.isReference()) {
        final ref = item.asReference()!;
        if (refs.contains(ref)) {
          throw OpenApiValidationException(
            '$path/$compositionType',
            'Duplicate reference "$ref" found in $compositionType array',
            specReference: 'OpenAPI 3.0.0 - Schema Object',
          );
        }
        refs.add(ref);
      }

      // Resolve the schema
      final resolved = _resolveAndGetSchema(item, '$path/$compositionType[$i]');
      if (resolved == null) continue;

      // Recursively enumerate branches from this option
      final subBranches = _enumerateBranches(resolved, '$path/$compositionType[$i]');

      // Prepend current level's accumulated schemas to each sub-branch
      for (final subBranch in subBranches) {
        branches.add(_SchemaBranch([...allOfSchemas, ...subBranch.schemas], subBranch.path));
      }
    }

    return branches;
  }

  /// Validates all constraints and compatibility rules for a single branch.
  ///
  /// A branch contains all schemas accumulated through allOf (including parent
  /// schemas) along a specific path determined by oneOf/anyOf choices.
  ///
  /// Validation strategy:
  /// 1. Ensure all schemas have explicit types and they're compatible
  /// 2. Determine the branch's schema type
  /// 3. Ensure all type-specific properties match the determined type
  /// 4. Validate type-specific constraints for the determined type only
  /// 5. Validate const and enum compatibility
  ///
  /// [branch] The branch to validate.
  ///
  /// Throws [OpenApiValidationException] if any validation fails.
  void _validateBranch(_SchemaBranch branch) {
    final schemas = branch.schemas;
    final path = branch.path;

    try {
      _validateSchemaList(schemas);
    } on _SchemaListValidationError catch (e) {
      throw OpenApiValidationException(path, e.message, specReference: e.specReference);
    }
  }

  /// Validates all constraints and compatibility rules for a list of schemas.
  ///
  /// This is the core validation logic that operates on a list of schemas without
  /// any branch-specific or path-specific context. It validates:
  /// 1. Explicit type requirements and compatibility
  /// 2. Implicit type consistency (type-specific properties match types)
  /// 3. Type-specific constraints
  /// 4. Const value compatibility
  /// 5. Enum value compatibility
  ///
  /// [schemas] The list of schemas to validate together.
  ///
  /// Throws [_SchemaListValidationError] if any validation fails.
  void _validateSchemaList(List<SchemaObject> schemas) {
    // Step 1: Validate explicit types and ensure all schemas have compatible types
    _validateExplicitTypes(schemas);

    // Step 2: Determine the effective schema type
    final schemaType = _determineSchemaType(schemas);

    // Step 3: Validate that all type-specific properties match the determined type
    _validateImplicitTypes(schemas, schemaType);

    // Step 4: Validate type-specific constraints for the determined type
    _validateConstraints(schemas, schemaType);

    // Step 5: Validate const compatibility
    _validateConsts(schemas);

    // Step 6: Validate enum compatibility
    _validateEnums(schemas);
  }

  /// Validates explicit type requirements and compatibility across schemas.
  ///
  /// This ensures that:
  /// 1. Every schema has an explicit `type` property
  /// 2. All explicit types are compatible (same type or compatible subtypes)
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if types are missing or incompatible.
  void _validateExplicitTypes(List<SchemaObject> schemas) {
    // Step 1: Validate that each schema has an explicit type
    for (final schema in schemas) {
      if (schema.type == null) {
        throw _SchemaListValidationError(
          'Schema must have an explicit "type" property. Types cannot be inferred from other properties.',
          specReference: 'OpenAPI 3.0.0 - Schema Object',
        );
      }
    }

    // Step 2: Collect types from all schemas
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
            throw _SchemaListValidationError(
              'Schema list contains incompatible types: $typeNames. A value cannot be both $pairNames simultaneously.',
              specReference: 'JSON Schema Core - allOf semantics',
            );
          }
        }
      }
    }
  }

  /// Determines the actual type after validating type compatibility.
  ///
  /// After ensuring all schemas have compatible types, this determines what the
  /// effective type is. Returns the most specific type.
  ///
  /// For example:
  /// - All schemas have `string` → returns `string`
  /// - Mix of `integer` and `number` → returns `integer` (most specific)
  /// - All empty parent schemas → returns first non-null type found
  ///
  /// [schemas] All schemas to analyze.
  ///
  /// Returns the determined schema type.
  SchemaType _determineSchemaType(List<SchemaObject> schemas) {
    // Collect all types
    final types = schemas.where((s) => s.type != null).map((s) => s.type!).toList();

    if (types.isEmpty) {
      // This shouldn't happen as _validateBranchExplicitTypes ensures all have types
      throw StateError('No types found in branch schemas');
    }

    // If all the same type, return it
    final uniqueTypes = types.toSet();
    if (uniqueTypes.length == 1) {
      return types.first;
    }

    // If mix of integer and number, prefer integer (most specific)
    if (uniqueTypes.contains(SchemaType.integer) && uniqueTypes.contains(SchemaType.number)) {
      return SchemaType.integer;
    }

    // Otherwise return the first type (they should all be compatible at this point)
    return types.first;
  }

  /// Validates that all type-specific properties match the explicit type.
  ///
  /// After determining the effective type, this ensures that all type-specific
  /// properties (like minLength, required, items, etc.) belong to that type and
  /// no properties from other types are present.
  ///
  /// Type-specific property groups:
  /// - String: minLength, maxLength, pattern
  /// - Number/Integer: minimum, maximum, exclusiveMinimum, exclusiveMaximum, multipleOf
  /// - Array: minItems, maxItems, uniqueItems, items
  /// - Object: minProperties, maxProperties, required, properties, additionalProperties, patternProperties
  ///
  /// [schemas] All schemas to validate.
  /// [schemaType] The determined type for these schemas.
  ///
  /// Throws [_SchemaListValidationError] if properties don't match the schema type.
  void _validateImplicitTypes(List<SchemaObject> schemas, SchemaType schemaType) {
    // Check that all type-specific properties match the determined schema type
    for (var i = 0; i < schemas.length; i++) {
      final schema = schemas[i];

      // Check for string-specific properties
      final hasStringProps = schema.minLength != null || schema.maxLength != null || schema.pattern != null;

      // Check for number/integer-specific properties
      final hasNumberProps =
          schema.minimum != null ||
          schema.maximum != null ||
          schema.exclusiveMinimum != null ||
          schema.exclusiveMaximum != null ||
          schema.multipleOf != null;

      // Check for array-specific properties
      final hasArrayProps =
          schema.minItems != null || schema.maxItems != null || schema.uniqueItems || schema.items != null;

      // Check for object-specific properties
      final hasObjectProps =
          schema.minProperties != null ||
          schema.maxProperties != null ||
          schema.required_ != null ||
          schema.properties != null ||
          schema.additionalProperties != null ||
          schema.patternProperties != null;

      // Validate properties match the schema type
      switch (schemaType) {
        case SchemaType.string:
          if (hasNumberProps) {
            throw _SchemaListValidationError(
              'Schema list has type "string" but contains number/integer properties (minimum/maximum/multipleOf).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasArrayProps) {
            throw _SchemaListValidationError(
              'Schema list has type "string" but contains array properties (minItems/maxItems/items).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasObjectProps) {
            throw _SchemaListValidationError(
              'Schema list has type "string" but contains object properties (properties/required/additionalProperties).',
              specReference: 'JSON Schema Core',
            );
          }
          break;

        case SchemaType.number:
        case SchemaType.integer:
          if (hasStringProps) {
            throw _SchemaListValidationError(
              'Schema list has type "${schemaType.name}" but contains string properties (minLength/maxLength/pattern).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasArrayProps) {
            throw _SchemaListValidationError(
              'Schema list has type "${schemaType.name}" but contains array properties (minItems/maxItems/items).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasObjectProps) {
            throw _SchemaListValidationError(
              'Schema list has type "${schemaType.name}" but contains object properties (properties/required/additionalProperties).',
              specReference: 'JSON Schema Core',
            );
          }
          break;

        case SchemaType.array:
          if (hasStringProps) {
            throw _SchemaListValidationError(
              'Schema list has type "array" but contains string properties (minLength/maxLength/pattern).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasNumberProps) {
            throw _SchemaListValidationError(
              'Schema list has type "array" but contains number/integer properties (minimum/maximum/multipleOf).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasObjectProps) {
            throw _SchemaListValidationError(
              'Schema list has type "array" but contains object properties (properties/required/additionalProperties).',
              specReference: 'JSON Schema Core',
            );
          }
          break;

        case SchemaType.object:
          if (hasStringProps) {
            throw _SchemaListValidationError(
              'Schema list has type "object" but contains string properties (minLength/maxLength/pattern).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasNumberProps) {
            throw _SchemaListValidationError(
              'Schema list has type "object" but contains number/integer properties (minimum/maximum/multipleOf).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasArrayProps) {
            throw _SchemaListValidationError(
              'Schema list has type "object" but contains array properties (minItems/maxItems/items).',
              specReference: 'JSON Schema Core',
            );
          }
          break;

        case SchemaType.boolean:
          if (hasStringProps) {
            throw _SchemaListValidationError(
              'Schema list has type "boolean" but contains string properties (minLength/maxLength/pattern).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasNumberProps) {
            throw _SchemaListValidationError(
              'Schema list has type "boolean" but contains number/integer properties (minimum/maximum/multipleOf).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasArrayProps) {
            throw _SchemaListValidationError(
              'Schema list has type "boolean" but contains array properties (minItems/maxItems/items).',
              specReference: 'JSON Schema Core',
            );
          }
          if (hasObjectProps) {
            throw _SchemaListValidationError(
              'Schema list has type "boolean" but contains object properties (properties/required/additionalProperties).',
              specReference: 'JSON Schema Core',
            );
          }
          break;

        case SchemaType.null_:
          // Null type has no specific properties to check
          break;
      }
    }
  }

  /// Validates type-specific constraints across all schemas.
  ///
  /// After confirming type consistency, this validates that all constraints
  /// for the determined type are coherent ACROSS all schemas.
  ///
  /// Only validates constraints relevant to the schema type:
  /// - String type → string constraints
  /// - Number/Integer type → numeric constraints
  /// - Array type → array constraints
  /// - Object type → object constraints
  /// - Boolean type → no specific constraints to validate
  ///
  /// [schemas] All schemas to validate.
  /// [schemaType] The determined type for these schemas.
  ///
  /// Throws [_SchemaListValidationError] if constraints are incoherent across schemas.
  void _validateConstraints(List<SchemaObject> schemas, SchemaType schemaType) {
    switch (schemaType) {
      case SchemaType.string:
        _validateStringConstraints(schemas);
        break;
      case SchemaType.number:
      case SchemaType.integer:
        _validateNumericConstraints(schemas);
        break;
      case SchemaType.array:
        _validateArrayConstraints(schemas);
        break;
      case SchemaType.object:
        _validateObjectConstraints(schemas);
        break;
      case SchemaType.boolean:
        // Boolean has no specific constraints to validate
        break;
      case SchemaType.null_:
        // Null type has no specific constraints to validate
        break;
    }
  }

  /// Validates numeric constraints across all schemas.
  ///
  /// Ensures that numeric bounds are coherent across all schemas:
  /// - max(all minimums) ≤ min(all maximums)
  /// - max(all exclusiveMinimums) < min(all exclusiveMaximums)
  ///
  /// This catches both single-schema conflicts and cross-schema conflicts.
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if constraints conflict.
  void _validateNumericConstraints(List<SchemaObject> schemas) {
    // Collect all numeric constraints across all schemas
    num? globalMinimum;
    num? globalMaximum;
    num? globalExclusiveMinimum;
    num? globalExclusiveMaximum;

    for (final schema in schemas) {
      // Collect constraints across schemas
      if (schema.minimum != null) {
        globalMinimum = globalMinimum == null
            ? schema.minimum
            : (schema.minimum! > globalMinimum ? schema.minimum : globalMinimum);
      }
      if (schema.maximum != null) {
        globalMaximum = globalMaximum == null
            ? schema.maximum
            : (schema.maximum! < globalMaximum ? schema.maximum : globalMaximum);
      }
      if (schema.exclusiveMinimum != null) {
        globalExclusiveMinimum = globalExclusiveMinimum == null
            ? schema.exclusiveMinimum
            : (schema.exclusiveMinimum! > globalExclusiveMinimum ? schema.exclusiveMinimum : globalExclusiveMinimum);
      }
      if (schema.exclusiveMaximum != null) {
        globalExclusiveMaximum = globalExclusiveMaximum == null
            ? schema.exclusiveMaximum
            : (schema.exclusiveMaximum! < globalExclusiveMaximum ? schema.exclusiveMaximum : globalExclusiveMaximum);
      }
    }

    // Validate cross-schema numeric constraints
    if (globalMinimum != null && globalMaximum != null && globalMinimum > globalMaximum) {
      throw _SchemaListValidationError(
        'Schema list constraints are incompatible: effective minimum ($globalMinimum) cannot be greater than effective maximum ($globalMaximum) across all schemas',
        specReference: 'JSON Schema Validation',
      );
    }

    if (globalExclusiveMinimum != null &&
        globalExclusiveMaximum != null &&
        globalExclusiveMinimum >= globalExclusiveMaximum) {
      throw _SchemaListValidationError(
        'Schema list constraints are incompatible: effective exclusiveMinimum ($globalExclusiveMinimum) must be less than effective exclusiveMaximum ($globalExclusiveMaximum) across all schemas',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Validates string constraints across all schemas.
  ///
  /// Ensures that string length bounds are coherent across all schemas:
  /// - max(all minLengths) ≤ min(all maxLengths)
  ///
  /// This catches both single-schema conflicts and cross-schema conflicts.
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if constraints conflict.
  void _validateStringConstraints(List<SchemaObject> schemas) {
    // Collect all string constraints across all schemas
    int? globalMinLength;
    int? globalMaxLength;

    for (final schema in schemas) {
      // Collect constraints across schemas
      if (schema.minLength != null) {
        globalMinLength = globalMinLength == null
            ? schema.minLength
            : (schema.minLength! > globalMinLength ? schema.minLength : globalMinLength);
      }
      if (schema.maxLength != null) {
        globalMaxLength = globalMaxLength == null
            ? schema.maxLength
            : (schema.maxLength! < globalMaxLength ? schema.maxLength : globalMaxLength);
      }
    }

    // Validate cross-schema string constraints
    if (globalMinLength != null && globalMaxLength != null && globalMinLength > globalMaxLength) {
      throw _SchemaListValidationError(
        'Schema list constraints are incompatible: effective minLength ($globalMinLength) cannot be greater than effective maxLength ($globalMaxLength) across all schemas',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Validates array constraints across all schemas.
  ///
  /// Coordinates validation of all array-specific constraints:
  /// 1. Min/max items bounds
  /// 2. UniqueItems consistency
  /// 3. Items schema compatibility
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if constraints conflict.
  void _validateArrayConstraints(List<SchemaObject> schemas) {
    _validateArrayMinMaxItems(schemas);
    _validateArrayUniqueItems(schemas);
    _validateArrayItems(schemas);
  }

  /// Validates array min/max items constraints across all schemas.
  ///
  /// Ensures that array size bounds are coherent across all schemas:
  /// - max(all minItems) ≤ min(all maxItems)
  ///
  /// This catches both single-schema conflicts and cross-schema conflicts.
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if constraints conflict.
  void _validateArrayMinMaxItems(List<SchemaObject> schemas) {
    // Collect all array constraints across all schemas
    int? globalMinItems;
    int? globalMaxItems;

    for (final schema in schemas) {
      // Collect constraints across schemas
      if (schema.minItems != null) {
        globalMinItems = globalMinItems == null
            ? schema.minItems
            : (schema.minItems! > globalMinItems ? schema.minItems : globalMinItems);
      }
      if (schema.maxItems != null) {
        globalMaxItems = globalMaxItems == null
            ? schema.maxItems
            : (schema.maxItems! < globalMaxItems ? schema.maxItems : globalMaxItems);
      }
    }

    // Validate cross-schema array constraints
    if (globalMinItems != null && globalMaxItems != null && globalMinItems > globalMaxItems) {
      throw _SchemaListValidationError(
        'Schema list constraints are incompatible: effective minItems ($globalMinItems) cannot be greater than effective maxItems ($globalMaxItems) across all schemas',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Validates that uniqueItems is consistent across all schemas.
  ///
  /// When multiple schemas specify the uniqueItems constraint, they must all agree.
  /// If one schema sets uniqueItems to true, all other schemas that specify it must
  /// also set it to true. Mixed values create ambiguous semantics.
  ///
  /// Valid:
  /// - All schemas have uniqueItems: true
  /// - All schemas have uniqueItems: false
  /// - Some schemas specify uniqueItems: true, others don't specify it (defaults to false)
  ///
  /// Invalid:
  /// - Some schemas have uniqueItems: true, others have uniqueItems: false
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if uniqueItems values conflict.
  void _validateArrayUniqueItems(List<SchemaObject> schemas) {
    // Collect all uniqueItems values that are explicitly set to true
    final uniqueItemsValues = schemas.map((s) => s.uniqueItems).toSet();

    // If we have both true and false (explicitly or by default), that's a conflict
    // Note: uniqueItems defaults to false if not specified
    if (uniqueItemsValues.contains(true) && uniqueItemsValues.length > 1) {
      throw _SchemaListValidationError(
        'Schema list has conflicting uniqueItems constraints: some schemas require unique items while others allow duplicates',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Validates items schemas across all schemas.
  ///
  /// When multiple schemas specify an items constraint, all items schemas must be
  /// compatible. This method collects all items schemas and validates them together
  /// using the core schema list validation.
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if items schemas are incompatible.
  void _validateArrayItems(List<SchemaObject> schemas) {
    // Collect all items schemas
    final itemsSchemas = <SchemaObject>[];

    for (final schema in schemas) {
      if (schema.items != null) {
        final itemsSchema = _resolveAndGetSchema(schema.items!, '');
        if (itemsSchema != null) {
          itemsSchemas.add(itemsSchema);
        }
      }
    }

    // If we have multiple items schemas, validate them together
    if (itemsSchemas.length > 1) {
      try {
        _validateSchemaList(itemsSchemas);
      } on _SchemaListValidationError catch (e) {
        // Re-throw with additional context about items
        throw _SchemaListValidationError(
          'Schema list has incompatible items schemas: ${e.message}',
          specReference: e.specReference,
        );
      }
    }
  }

  /// Validates object constraints across all schemas.
  ///
  /// Coordinates validation of all object-specific constraints:
  /// 1. Min/max properties bounds
  /// 2. Property schema compatibility
  /// 3. Required properties existence
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if constraints conflict.
  void _validateObjectConstraints(List<SchemaObject> schemas) {
    _validateObjectMinMaxProperties(schemas);
    _validateObjectProperties(schemas);
    _validateObjectRequired(schemas);
  }

  /// Validates object min/max properties constraints across all schemas.
  ///
  /// Ensures that object property count bounds are coherent across all schemas:
  /// - max(all minProperties) ≤ min(all maxProperties)
  ///
  /// This catches both single-schema conflicts and cross-schema conflicts.
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if constraints conflict.
  void _validateObjectMinMaxProperties(List<SchemaObject> schemas) {
    // Collect all object constraints across all schemas
    int? globalMinProperties;
    int? globalMaxProperties;

    for (final schema in schemas) {
      // Collect constraints across schemas
      if (schema.minProperties != null) {
        globalMinProperties = globalMinProperties == null
            ? schema.minProperties
            : (schema.minProperties! > globalMinProperties ? schema.minProperties : globalMinProperties);
      }
      if (schema.maxProperties != null) {
        globalMaxProperties = globalMaxProperties == null
            ? schema.maxProperties
            : (schema.maxProperties! < globalMaxProperties ? schema.maxProperties : globalMaxProperties);
      }
    }

    // Validate cross-schema object constraints
    if (globalMinProperties != null && globalMaxProperties != null && globalMinProperties > globalMaxProperties) {
      throw _SchemaListValidationError(
        'Schema list constraints are incompatible: effective minProperties ($globalMinProperties) cannot be greater than effective maxProperties ($globalMaxProperties) across all schemas',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Validates property schemas across all schemas.
  ///
  /// When multiple schemas define the same property name, all schemas for that
  /// property must be compatible. This method:
  /// 1. Collects all unique property names across all schemas
  /// 2. For each property name, collects all schemas that define it
  /// 3. Validates each property's schemas together using core schema list validation
  ///
  /// For example, if Schema A defines property "age" as {type: integer, minimum: 0}
  /// and Schema B defines "age" as {type: integer, maximum: 120}, both schemas
  /// must be compatible (which they are in this case).
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if property schemas are incompatible.
  void _validateObjectProperties(List<SchemaObject> schemas) {
    // Collect all unique property names across all schemas
    final allPropertyNames = <String>{};
    for (final schema in schemas) {
      if (schema.properties != null) {
        allPropertyNames.addAll(schema.properties!.keys);
      }
    }

    // For each unique property name, validate all its schemas together
    for (final propertyName in allPropertyNames) {
      final propertySchemas = <SchemaObject>[];

      // Collect all schemas for this property
      for (final schema in schemas) {
        if (schema.properties != null && schema.properties!.containsKey(propertyName)) {
          final propertySchemaRef = schema.properties![propertyName]!;
          final propertySchema = _resolveAndGetSchema(propertySchemaRef, '');
          if (propertySchema != null) {
            propertySchemas.add(propertySchema);
          }
        }
      }

      // Validate this property's schemas together if we have multiple
      if (propertySchemas.length > 1) {
        try {
          _validateSchemaList(propertySchemas);
        } on _SchemaListValidationError catch (e) {
          // Re-throw with additional context about which property
          throw _SchemaListValidationError(
            'Schema list has incompatible schemas for property "$propertyName": ${e.message}',
            specReference: e.specReference,
          );
        }
      }
    }
  }

  /// Validates that all required properties have corresponding property definitions.
  ///
  /// When schemas specify required properties, those properties must be defined
  /// in at least one schema's properties map across all schemas. This ensures
  /// that required properties actually exist.
  ///
  /// For example:
  /// - Schema A: required: ["name", "age"], properties: {name: {...}, age: {...}} ✓
  /// - Schema A: required: ["name"], Schema B: properties: {name: {...}} ✓
  /// - Schema A: required: ["name"], properties: {} ✗ (name not defined anywhere)
  ///
  /// [schemas] All schemas to validate.
  ///
  /// Throws [_SchemaListValidationError] if required properties are not defined.
  void _validateObjectRequired(List<SchemaObject> schemas) {
    // Collect all required properties across all schemas
    final allRequired = <String>{};
    for (final schema in schemas) {
      if (schema.required_ != null) {
        allRequired.addAll(schema.required_!);
      }
    }

    // Collect all defined properties across all schemas
    final allDefinedProperties = <String>{};
    for (final schema in schemas) {
      if (schema.properties != null) {
        allDefinedProperties.addAll(schema.properties!.keys);
      }
    }

    // Check that every required property is defined somewhere
    final missingProperties = allRequired.difference(allDefinedProperties);
    if (missingProperties.isNotEmpty) {
      throw _SchemaListValidationError(
        'Schema list has required properties that are not defined: ${missingProperties.join(", ")}',
        specReference: 'JSON Schema Validation',
      );
    }
  }

  /// Resolves a schema reference and returns the schema object.
  ///
  /// If the referenceable is a direct value, returns it.
  /// If it's a reference, resolves it using the reference resolver.
  ///
  /// [schemaRef] The referenceable schema.
  /// [path] JSON Pointer path for error reporting.
  ///
  /// Returns the resolved schema or null if resolution fails.
  SchemaObject? _resolveAndGetSchema(Referenceable<SchemaObject> schemaRef, String path) {
    if (schemaRef.isReference()) {
      return resolver.resolveSchemaRef(schemaRef, path);
    }
    return schemaRef.asValue();
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
  /// [schemas] The resolved schemas.
  ///
  /// Throws [_SchemaListValidationError] if multiple different const values exist.
  void _validateConsts(List<SchemaObject> schemas) {
    // Collect const values from all schemas
    final constValues = schemas.where((s) => s.const_ != null).map((s) => s.const_).toList();

    if (constValues.length > 1) {
      final uniqueConsts = constValues.toSet();
      if (uniqueConsts.length > 1) {
        throw _SchemaListValidationError(
          'Schema list contains multiple different const values: ${constValues.join(", ")}. This schema can never be satisfied.',
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
  /// [schemas] The resolved schemas.
  ///
  /// Throws [_SchemaListValidationError] if enum sets have no intersection.
  void _validateEnums(List<SchemaObject> schemas) {
    // Collect enum lists from all schemas
    final enumLists = schemas.where((s) => s.enum_ != null).map((s) => s.enum_!).toList();

    if (enumLists.length > 1) {
      // Find intersection of all enums
      var intersection = enumLists[0].toSet();
      for (var i = 1; i < enumLists.length; i++) {
        intersection = intersection.intersection(enumLists[i].toSet());
      }

      if (intersection.isEmpty) {
        throw _SchemaListValidationError(
          'Schema list contains enum constraints with no common values. This schema can never be satisfied.',
          specReference: 'JSON Schema Core - allOf semantics',
        );
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

/// Represents a single branch in a schema's composition structure.
///
/// A branch is created by following a specific path through oneOf/anyOf choices.
/// It contains all schemas accumulated via allOf (including parent schemas)
/// along that path.
///
/// For example, given:
/// ```yaml
/// type: object
/// oneOf:
///   - type: string
///   - type: number
/// ```
///
/// This creates two branches:
/// - Branch 1: [parent schema, {type: string}]
/// - Branch 2: [parent schema, {type: number}]
class _SchemaBranch {
  /// All schemas accumulated in this branch (parent + allOf chain).
  final List<SchemaObject> schemas;

  /// JSON Pointer path to this branch for error reporting.
  final String path;

  _SchemaBranch(this.schemas, this.path);
}

/// Exception thrown by schema list validation methods.
///
/// This exception contains validation error details without path information,
/// allowing it to be caught and wrapped with path context by higher-level
/// validation methods (e.g., branch validation).
class _SchemaListValidationError {
  /// The error message describing what validation failed.
  final String message;

  /// The OpenAPI/JSON Schema specification reference.
  final String specReference;

  _SchemaListValidationError(this.message, {required this.specReference});

  @override
  String toString() => 'SchemaListValidationError: $message (Spec: $specReference)';
}

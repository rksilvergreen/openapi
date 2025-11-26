# Composition Keyword Validation Enhancements

## Overview
Enhanced strict validation for `allOf`, `oneOf`, `anyOf`, and `not` keywords in the OpenAPI 3.0.0 Schema Object validator, based on JSON Schema Core specification and OpenAPI 3.0.0 requirements.

**Key Enhancement**: The validator now **resolves internal schema references** (e.g., `#/components/schemas/Dog`) during semantic validation, enabling detection of incompatible types and other semantic errors even when schemas are referenced rather than inline.

## Enhanced Validations

### 1. Basic Structure Validation (Already Existed, Now Enhanced)
- ✅ Value MUST be a non-empty array (for allOf/oneOf/anyOf)
- ✅ Each item MUST be a Schema Object (Map) or Reference Object
- ✅ Better error messages with specific spec references

### 2. Schema Well-formedness Validation (New)
- ✅ Validates that $ref is a non-empty string when present
- ✅ Checks for valid Schema Object properties
- ✅ Validates that schemas are properly formed

### 3. Semantic Validation for allOf with Reference Resolution (New & Enhanced)
#### Incompatible Types Detection
- ✅ Detects when allOf contains schemas with incompatible types (e.g., string + object)
- ✅ **Now resolves internal references** to check types across referenced schemas
- Example: A schema cannot be both a string AND an object simultaneously
- Works with both inline schemas and `$ref` to `#/components/schemas/...`

#### Contradictory Const Values (JSON Schema feature)
- ✅ Detects when allOf contains different const values
- Note: `const` is not in OpenAPI 3.0.0 but is in later JSON Schema versions

#### Disjoint Enum Values
- ✅ Detects when allOf contains enum arrays with no common values
- ✅ **Resolves references** to check enums across referenced schemas
- Example: `enum: [1,2,3]` combined with `enum: [4,5,6]` is impossible to satisfy

### 4. Duplicate Reference Detection (New)
- ✅ Detects when the same $ref is used multiple times in composition arrays
- Example: `oneOf: [{$ref: Cat}, {$ref: Cat}]` is redundant

### 5. Discriminator Validation (Enhanced)
- ✅ Validates that discriminator is only used with oneOf, anyOf, or allOf
- Per OpenAPI 3.0.0 spec: "The discriminator attribute is legal only when using one of the composite keywords `oneOf`, `anyOf`, `allOf`"

### 6. Not Keyword Validation (Enhanced)
- ✅ Validates that `not` contains a valid Schema Object
- ✅ Better error messages and spec references

## Test Cases

### Valid Schemas (All Pass ✓)
- Basic oneOf with multiple types
- Basic anyOf with constraints
- Basic allOf for composition
- oneOf/anyOf/allOf with discriminator
- allOf with references

### Invalid Schemas (All Caught ✗)
1. **Empty Composition Array**
   ```yaml
   allOf: []  # ✗ MUST contain at least one schema
   ```

2. **Incompatible Types in allOf**
   ```yaml
   allOf:
     - type: string
     - type: object  # ✗ Cannot be both string AND object
   ```

3. **Disjoint Enums in allOf**
   ```yaml
   allOf:
     - enum: [1, 2, 3]
     - enum: [4, 5, 6]  # ✗ No common value
   ```

4. **Discriminator Without Composition**
   ```yaml
   type: object
   discriminator:
     propertyName: type  # ✗ Requires oneOf/anyOf/allOf
   ```

5. **Duplicate References**
   ```yaml
   oneOf:
     - $ref: '#/components/schemas/Cat'
     - $ref: '#/components/schemas/Cat'  # ✗ Redundant
   ```

## Specification References

### JSON Schema Core - Section 10.2.1
**10.2.1.1. allOf**
> This keyword's value MUST be a non-empty array. Each item of the array MUST be a valid JSON Schema.
> An instance validates successfully against this keyword if it validates successfully against all schemas defined by this keyword's value.

**10.2.1.2. anyOf**
> This keyword's value MUST be a non-empty array. Each item of the array MUST be a valid JSON Schema.
> An instance validates successfully against this keyword if it validates successfully against at least one schema defined by this keyword's value.

**10.2.1.3. oneOf**
> This keyword's value MUST be a non-empty array. Each item of the array MUST be a valid JSON Schema.
> An instance validates successfully against this keyword if it validates successfully against exactly one schema defined by this keyword's value.

**10.2.1.4. not**
> This keyword's value MUST be a valid JSON Schema.
> An instance is valid against this keyword if it fails to validate successfully against the schema defined by this keyword.

### OpenAPI 3.0.0 Specification
From the Schema Object section:
- `allOf` - Inline or referenced schema MUST be of a Schema Object and not a standard JSON Schema.
- `oneOf` - Inline or referenced schema MUST be of a Schema Object and not a standard JSON Schema.
- `anyOf` - Inline or referenced schema MUST be of a Schema Object and not a standard JSON Schema.
- `not` - Inline or referenced schema MUST be of a Schema Object and not a standard JSON Schema.

From the Discriminator Object section:
> The discriminator attribute is legal only when using one of the composite keywords `oneOf`, `anyOf`, `allOf`.

## Files Modified
- `lib/v3_0_0/validator/src/schema_object_validator.dart`
  - Enhanced `_validateCompositionKeyword()` method
  - Added `_validateCompositionSchema()` method
  - Added `_validateCompositionSemantics()` method
  - Added `_validateAllOfSemantics()` method with reference resolution
  - Added `_resolveInternalReference()` helper method for resolving `#/components/schemas/...` refs
  - Enhanced `_validateDiscriminator()` method
  - Enhanced `_validateNotKeyword()` method
  - Added optional `document` parameter throughout to enable reference resolution

- `lib/v3_0_0/validator/src/openapi_object_validator.dart`
  - Updated to pass full document context to `ComponentsObjectValidator`

- `lib/v3_0_0/validator/src/components_object_validator.dart`
  - Updated to accept and pass document context to `SchemaObjectValidator`

## Test Files Created
- `bin/composition_validation_test.yaml` - Valid composition examples
- `bin/test_invalid_empty_allof.yaml` - Tests empty array detection
- `bin/test_invalid_allof_incompatible_types.yaml` - Tests type incompatibility
- `bin/test_invalid_allof_different_const.yaml` - Tests const conflicts
- `bin/test_invalid_allof_disjoint_enums.yaml` - Tests disjoint enum detection
- `bin/test_invalid_discriminator_without_composition.yaml` - Tests discriminator restriction
- `bin/test_invalid_duplicate_refs.yaml` - Tests duplicate reference detection

## Testing

All validations have been tested and confirmed working:

```bash
# Valid schema passes
$ dart run bin/openapi_analyzer.dart validate -f bin/composition_validation_test.yaml
✓ Validation successful: OpenAPI 3.0.0 specification is valid

# Invalid schemas are caught
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_empty_allof.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidEmptyAllOf/allOf: allOf array MUST contain at least one schema...

$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_allof_incompatible_types.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidAllOfIncompatibleTypes/allOf: allOf contains schemas with incompatible types...

$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_allof_disjoint_enums.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidAllOfDisjointEnums/allOf: allOf contains schemas with disjoint enum values...

$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_discriminator_without_composition.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidDiscriminatorAlone/discriminator: discriminator is only legal when used with one of the composite keywords...

$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_duplicate_refs.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidDuplicateRefs/oneOf: Duplicate reference "#/components/schemas/Cat" found in oneOf array...

# Real-world example: Catches error in inventory_alert.yaml
$ dart run bin/openapi_analyzer.dart validate -f bin/main.yaml
✗ Validation failed:
Validation error at /components/schemas/InventoryAlert: External reference "inventory_alert.yaml" validation failed: allOf contains schemas with incompatible types (string, object)...
```

## Benefits

1. **Stricter Validation**: Catches semantic errors that were previously undetected
2. **Better Error Messages**: Clear, spec-referenced error messages help developers understand issues
3. **Prevents Invalid Schemas**: Catches impossible-to-satisfy schemas at validation time
4. **Spec Compliance**: Full compliance with JSON Schema Core and OpenAPI 3.0.0 specifications
5. **Developer-Friendly**: Prevents common mistakes like duplicate refs and incompatible types

## Future Enhancements

Potential additional validations:
- Circular reference detection
- Performance optimization for large schema arrays
- More sophisticated type compatibility checking
- Warning system for suspicious but technically valid patterns
- Support for conditional composition (if/then/else)


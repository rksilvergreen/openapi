# Discriminator Property Validation

## Overview
Enhanced validation for the `discriminator` object in OpenAPI 3.0.0 schemas. The validator now performs comprehensive checks on the discriminator property to ensure it's properly defined and usable across all variant schemas.

## The Problem

### Before Enhancement
The validator only checked:
- ✅ That `discriminator` is used with `oneOf`, `anyOf`, or `allOf`
- ✅ That the discriminator object structure is valid

But it **didn't check**:
- ❌ That the discriminator property actually exists in the variant schemas
- ❌ That the property is marked as required
- ❌ That the property types are consistent across schemas

### Example of Previously Undetected Error
```yaml
ValidAnyOfWithDiscriminator:
  anyOf:
    - $ref: '#/components/schemas/Cat'
    - $ref: '#/components/schemas/Dog'
  discriminator:
    propertyName: cherry  # ❌ This property doesn't exist!

Cat:
  type: object
  required: [petType, meow]  # Has petType, not cherry
  properties:
    petType:
      type: string
    meow:
      type: boolean

Dog:
  type: object
  required: [petType, bark]  # Has petType, not cherry
  properties:
    petType:
      type: string
    bark:
      type: boolean
```

This would **incorrectly pass validation** before, even though the discriminator references a non-existent property.

## Solution

### New Validation Checks

The validator now performs **four critical checks** on discriminator usage:

#### 1. Property Existence Check
**Validates**: The discriminator property must exist in all variant schemas

```yaml
# ❌ FAILS: Property doesn't exist
Pet:
  oneOf:
    - $ref: '#/components/schemas/Cat'
    - $ref: '#/components/schemas/Dog'
  discriminator:
    propertyName: animalType  # Neither Cat nor Dog has this property
```

**Error Message**:
```
Discriminator property "animalType" does not exist in the following schemas: 
#/components/schemas/Cat, #/components/schemas/Dog. 
The discriminator property must be defined in all variant schemas.
```

#### 2. Required Field Check
**Validates**: The discriminator property must be in the `required` array of all variant schemas

```yaml
# ❌ FAILS: Property exists but not required
Cat:
  type: object
  required: [name]  # petType is missing from required
  properties:
    petType:
      type: string
    name:
      type: string
```

**Error Message**:
```
Discriminator property "petType" is not marked as required in the following schemas: 
#/components/schemas/Cat, #/components/schemas/Dog. 
The discriminator property should be required in all variant schemas for proper discrimination.
```

**Why This Matters**: If the discriminator property is optional, instances might not include it, making it impossible to determine which schema variant to use.

#### 3. Type Consistency Check
**Validates**: The discriminator property must have consistent types across all variant schemas

```yaml
# ❌ FAILS: Inconsistent types
Cat:
  type: object
  properties:
    petType:
      type: string  # string type

Dog:
  type: object
  properties:
    petType:
      type: integer  # integer type - inconsistent!
```

**Error Message**:
```
Discriminator property "petType" has inconsistent types across schemas: string, integer. 
The discriminator property should have the same type (typically string) in all variant schemas.
```

#### 4. String Type Enforcement
**Validates**: The discriminator property should be of type `string`

```yaml
# ❌ FAILS: Non-string type
Cat:
  type: object
  properties:
    petType:
      type: integer  # Should be string
```

**Error Message**:
```
Discriminator property "petType" has type "integer". 
Discriminator properties should be of type "string" for proper identification of schema variants.
```

**Why This Matters**: Discriminators typically use string values to identify schema variants (e.g., "Cat", "Dog"). Using other types can cause issues with serialization and client code generation.

#### 5. Nested Composition Keywords Check (New)
**Validates**: Discriminator should not be used with `allOf` that contains nested composition keywords

```yaml
# ❌ FAILS: Nested composition in allOf with discriminator
Pet:
  allOf:
    - type: object
      properties:
        petType:
          type: string
    - oneOf:
        - $ref: '#/components/schemas/Cat'
        - $ref: '#/components/schemas/Dog'
    - oneOf:
        - $ref: '#/components/schemas/Train'
        - $ref: '#/components/schemas/Boat'
  discriminator:
    propertyName: petType  # Ambiguous - which variant does it identify?
```

**Error Message**:
```
Discriminator should not be used with allOf that contains nested composition keywords (oneOf, anyOf, allOf). 
This creates ambiguity about which schema variant the discriminator value represents. 
Use discriminator directly with oneOf/anyOf containing all variants, or ensure allOf only contains direct schema definitions or references.
```

**Why This Matters**: Discriminators are designed to identify "which ONE" of several variants an instance represents. When used with `allOf` containing nested `oneOf`/`anyOf`, it's ambiguous which variant the discriminator identifies - the instance must satisfy multiple variants simultaneously, defeating the purpose of discrimination.

**Correct Patterns**:
```yaml
# ✅ GOOD: Discriminator with oneOf
Pet:
  oneOf:
    - $ref: '#/components/schemas/Cat'
    - $ref: '#/components/schemas/Dog'
  discriminator:
    propertyName: petType

# ✅ GOOD: Discriminator in nested oneOf within allOf
Pet:
  allOf:
    - oneOf:
        - $ref: '#/components/schemas/Cat'
        - $ref: '#/components/schemas/Dog'
      discriminator:
        propertyName: petType
    - type: object
      properties:
        # Additional common properties
```

## Valid Discriminator Usage

### Correct Example
```yaml
Pet:
  oneOf:
    - $ref: '#/components/schemas/Cat'
    - $ref: '#/components/schemas/Dog'
  discriminator:
    propertyName: petType  # ✅ Correct property name

Cat:
  type: object
  required: [petType, meow]  # ✅ petType is required
  properties:
    petType:
      type: string  # ✅ String type
    meow:
      type: boolean

Dog:
  type: object
  required: [petType, bark]  # ✅ petType is required
  properties:
    petType:
      type: string  # ✅ String type, consistent with Cat
    bark:
      type: boolean
```

This passes all validations:
- ✅ `petType` exists in both Cat and Dog
- ✅ `petType` is required in both schemas
- ✅ `petType` has consistent type (string) across schemas
- ✅ `petType` is a string type

## Implementation Details

### Key Functions

#### `_validateDiscriminator()` - Enhanced
Now extracts the composition schemas and validates the discriminator property:
```dart
if (discriminator.containsKey('propertyName') && document != null) {
  final propertyName = discriminator['propertyName'] as String;
  
  // Get the composition schemas (oneOf/anyOf/allOf)
  List<dynamic>? compositionSchemas;
  String? compositionKeyword;
  
  if (data.containsKey('oneOf')) {
    compositionSchemas = data['oneOf'] as List;
    compositionKeyword = 'oneOf';
  } // ... handle anyOf and allOf
  
  if (compositionSchemas != null && compositionKeyword != null) {
    _validateDiscriminatorProperty(
      propertyName,
      compositionSchemas,
      compositionKeyword,
      path,
      document,
    );
  }
}
```

#### `_validateDiscriminatorProperty()` - New
Performs comprehensive discriminator property validation:

1. **Resolves all schemas** (including `$ref` references)
2. **Checks each schema** for:
   - Property existence in `properties` object
   - Property presence in `required` array
   - Property type definition
3. **Validates consistency** across all schemas
4. **Reports detailed errors** with schema names

### Reference Resolution
Works seamlessly with the existing reference resolution system:
```dart
// Resolve references to get actual schema definitions
if (schema.containsKey(r'$ref')) {
  final ref = schema[r'$ref'] as String;
  schemaName = ref; // Use ref as schema name in error messages
  final resolvedSchema = _resolveInternalReference(ref, document);
  if (resolvedSchema != null) {
    schema = resolvedSchema;
  }
}
```

This allows the validator to check discriminator properties **even when schemas are referenced** rather than inline.

## Test Coverage

| Test Case | Scenario | Result |
|-----------|----------|--------|
| Valid discriminator | Property exists, required, string type | ✓ Pass |
| Property missing | Property doesn't exist in schemas | ✗ Fail |
| Property not required | Property exists but not in required array | ✗ Fail |
| Inconsistent types | Property has different types across schemas | ✗ Fail |
| Non-string type | Property is integer/boolean instead of string | ✗ Fail |
| Nested composition | allOf contains nested oneOf/anyOf with discriminator | ✗ Fail |

## Test Files

- `bin/composition_validation_test.yaml` - Valid discriminator usage
- `bin/test_invalid_discriminator_property_missing.yaml` - Property doesn't exist
- `bin/test_invalid_discriminator_not_required.yaml` - Property not required
- `bin/test_invalid_discriminator_inconsistent_types.yaml` - Inconsistent types
- `bin/test_invalid_discriminator_non_string_type.yaml` - Non-string type
- `bin/test_invalid_discriminator_nested_composition.yaml` - Nested composition keywords in allOf

## Files Modified

### `schema_object_validator.dart` (~130 lines added)
- Enhanced `_validateDiscriminator()` - Added discriminator property validation
- Added `_validateDiscriminatorProperty()` - New comprehensive validation function
- Added document parameter threading for reference resolution

## Benefits

1. **Catches Real Errors**: Detects typos and mistakes in discriminator property names
2. **Enforces Best Practices**: Ensures discriminator properties are required and string-typed
3. **Works with References**: Resolves `$ref` to validate properties in referenced schemas
4. **Clear Error Messages**: Specifies exactly which schemas have issues and what the problem is
5. **Prevents Runtime Issues**: Catches discriminator problems at validation time instead of runtime

## Example Error Output

### Property Missing
```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_discriminator_property_missing.yaml
✗ Validation failed:
Validation error at components/schemas.Pet/discriminator: 
Discriminator property "animalType" does not exist in the following schemas: 
#/components/schemas/Cat, #/components/schemas/Dog. 
The discriminator property must be defined in all variant schemas. 
(See: OpenAPI 3.0.0 - Discriminator Object)
```

### Property Not Required
```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_discriminator_not_required.yaml
✗ Validation failed:
Validation error at components/schemas.Pet/discriminator: 
Discriminator property "petType" is not marked as required in the following schemas: 
#/components/schemas/Cat, #/components/schemas/Dog. 
The discriminator property should be required in all variant schemas for proper discrimination. 
(See: OpenAPI 3.0.0 - Discriminator Object)
```

### Inconsistent Types
```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_discriminator_inconsistent_types.yaml
✗ Validation failed:
Validation error at components/schemas.Pet/discriminator: 
Discriminator property "petType" has inconsistent types across schemas: string, integer. 
The discriminator property should have the same type (typically string) in all variant schemas. 
(See: OpenAPI 3.0.0 - Discriminator Object)
```

## OpenAPI 3.0.0 Spec Compliance

Per the OpenAPI 3.0.0 specification:

> **Discriminator Object**: When request bodies or response payloads may be one of a number of different schemas, a discriminator object can be used to aid in serialization, deserialization, and validation. The discriminator is a specific object in a schema which is used to inform the consumer of the specification of an alternative schema based on the value associated with it.

> **propertyName**: REQUIRED. The name of the property in the payload that will hold the discriminator value.

The enhanced validation ensures that:
- The property name actually exists in the schemas
- The property can reliably hold discriminator values (is required)
- The property is consistently defined across all variants
- The property uses an appropriate type for discrimination (string)

These checks align with the intent of the discriminator mechanism and prevent common mistakes that would cause issues in code generation and API usage.


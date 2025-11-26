# Discriminator with Nested Composition Keywords - Validation

## Overview
Added validation to prevent the use of `discriminator` with `allOf` that contains nested composition keywords (`oneOf`, `anyOf`, `allOf`). This pattern creates semantic ambiguity about what the discriminator value represents.

## The Problem

### Invalid Pattern
```yaml
Pet:
  allOf:
    - type: object
      required: [petType]
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
    propertyName: petType  # ❌ Ambiguous!
```

### Why It's Invalid

1. **Ambiguous Identification**: The discriminator is meant to identify "which ONE" schema variant an instance represents
2. **Multiple Variants Required**: With `allOf` containing two `oneOf` blocks, an instance must satisfy:
   - One of (Cat OR Dog) AND
   - One of (Train OR Boat)
3. **What Does petType Mean?**: The discriminator value can't clearly identify which variant - is it "Cat", "Train", or "CatTrain"?

### Technical Details

While the schema itself is technically satisfiable (an instance could have properties from both Cat and Train), the discriminator pattern doesn't make sense in this context because:
- Discriminators are for identifying a single variant
- This pattern requires satisfying multiple variants
- The discriminator value has no clear meaning

## The Solution

The validator now detects this pattern and rejects it:

```bash
✗ Validation failed:
Validation error at components/schemas.Pet/discriminator: 
Discriminator should not be used with allOf that contains nested composition keywords (oneOf, anyOf, allOf). 
This creates ambiguity about which schema variant the discriminator value represents. 
Use discriminator directly with oneOf/anyOf containing all variants, or ensure allOf only contains direct schema definitions or references.
```

## Correct Patterns

### Pattern 1: Direct oneOf with Discriminator
```yaml
# ✅ CORRECT: Discriminator with oneOf at top level
Pet:
  oneOf:
    - $ref: '#/components/schemas/Cat'
    - $ref: '#/components/schemas/Dog'
    - $ref: '#/components/schemas/Train'
    - $ref: '#/components/schemas/Boat'
  discriminator:
    propertyName: petType
```

### Pattern 2: allOf with Direct Schemas/References
```yaml
# ✅ CORRECT: allOf with only direct schemas or references
ExtendedCat:
  allOf:
    - $ref: '#/components/schemas/Cat'
    - type: object
      properties:
        specialAbility:
          type: string
  # No discriminator needed here - allOf is for composition, not discrimination
```

### Pattern 3: Discriminator in Nested oneOf
```yaml
# ✅ CORRECT: Discriminator within the oneOf, not at allOf level
Pet:
  allOf:
    - oneOf:
        - $ref: '#/components/schemas/Cat'
        - $ref: '#/components/schemas/Dog'
      discriminator:
        propertyName: petType
    - type: object
      properties:
        commonProperty:
          type: string
```

## Implementation

### New Validation Function
Added `_validateDiscriminatorNotNestedInAllOf()`:

```dart
static void _validateDiscriminatorNotNestedInAllOf(List<dynamic> schemas, String path) {
  // Check if any schema in the allOf contains nested oneOf, anyOf, or allOf
  for (var i = 0; i < schemas.length; i++) {
    if (schemas[i] is Map) {
      final schema = schemas[i] as Map;
      
      // Check for nested composition keywords (but not $ref, as refs are fine)
      if (!schema.containsKey(r'$ref')) {
        if (schema.containsKey('oneOf') || 
            schema.containsKey('anyOf') || 
            schema.containsKey('allOf')) {
          throw OpenApiValidationException(...);
        }
      }
    }
  }
}
```

### Integration
Called from `_validateDiscriminator()` when the composition keyword is `allOf`:

```dart
if (compositionKeyword == 'allOf') {
  _validateDiscriminatorNotNestedInAllOf(compositionSchemas, path);
}
```

## Test Coverage

**Test File**: `bin/test_invalid_discriminator_nested_composition.yaml`

**Test Case**: allOf with two nested oneOf blocks and a discriminator

**Expected Result**: ✗ Validation fails with clear error message

**Actual Result**: ✓ Works as expected

```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_discriminator_nested_composition.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidAllOfWithDiscriminator/discriminator: 
Discriminator should not be used with allOf that contains nested composition keywords...
```

## Benefits

1. **Prevents Semantic Confusion**: Catches patterns that don't make sense with discriminators
2. **Clear Error Messages**: Explains why the pattern is invalid and suggests correct alternatives
3. **Guides Best Practices**: Helps developers use discriminators correctly
4. **Prevents Runtime Issues**: Catches problems at validation time rather than runtime

## Edge Cases Handled

### ✅ Allowed: References in allOf
```yaml
allOf:
  - $ref: '#/components/schemas/Cat'  # ✅ Reference is OK
  - $ref: '#/components/schemas/Dog'  # ✅ Reference is OK
discriminator:
  propertyName: petType
```
References are allowed because they don't create the ambiguity issue.

### ✗ Rejected: Inline Nested Composition
```yaml
allOf:
  - oneOf: [...]  # ✗ Inline nested composition
discriminator:
  propertyName: petType
```

### ✅ Allowed: oneOf/anyOf at Top Level
```yaml
oneOf:  # ✅ Top-level oneOf is fine
  - $ref: '#/components/schemas/Cat'
  - oneOf: [...]  # ✅ Can nest within the variant
discriminator:
  propertyName: petType
```

## Spec Alignment

While the OpenAPI 3.0.0 spec doesn't explicitly forbid this pattern, it violates the semantic intent of discriminators:

> "The discriminator is a specific object in a schema which is used to inform the consumer of the specification of an alternative schema based on the value associated with it."

The key word is "alternative" - discriminators are for choosing between alternatives, not for identifying combinations.

## Files Modified

- `lib/v3_0_0/validator/src/schema_object_validator.dart` - Added validation function (~20 lines)
- `bin/composition_validation_test.yaml` - Removed invalid pattern
- `bin/test_invalid_discriminator_nested_composition.yaml` - New test file
- Documentation updated

## Conclusion

This validation prevents a semantically confusing pattern and guides developers toward correct discriminator usage. While the nested composition pattern itself is valid for `allOf`, combining it with a discriminator creates ambiguity that defeats the purpose of discrimination.


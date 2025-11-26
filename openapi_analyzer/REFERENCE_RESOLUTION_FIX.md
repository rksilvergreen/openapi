# Reference Resolution Fix for Composition Validation

## Problem
The test file `test_invalid_allof_incompatible_types.yaml` was **incorrectly passing validation** when it should have failed. The schema combined incompatible types:

```yaml
InvalidAllOfIncompatibleTypes:
  allOf:
    - type: string
    - $ref: "#/components/schemas/Dog"  # Dog has type: object
```

An instance cannot be both a `string` AND an `object`, so this schema is semantically invalid and impossible to satisfy.

## Root Cause
The semantic validation in `_validateAllOfSemantics()` only checked the `type` field in **inline schemas**, not in **referenced schemas**. When it encountered:

```dart
if (schema.containsKey('type') && schema['type'] is String) {
  types.add(schema['type'] as String);
}
```

It would only collect `"string"` from the inline schema, missing the `"object"` type from the referenced Dog schema.

## Solution
Enhanced the validator to **resolve internal references** during semantic validation:

### 1. Added Document Context Parameter
Threaded an optional `document` parameter through the validation chain:
- `OpenApiObjectValidator.validate()` → passes full document
- `ComponentsObjectValidator.validate()` → passes document to schema validation
- `SchemaObjectValidator.validate()` → uses document for reference resolution

### 2. Implemented Reference Resolution
Added `_resolveInternalReference()` method that resolves JSON Pointer references like `#/components/schemas/Dog`:

```dart
static Map<dynamic, dynamic>? _resolveInternalReference(String ref, Map<dynamic, dynamic> document) {
  if (!ref.startsWith('#/')) {
    return null;  // Only handle internal references
  }
  
  // Navigate through document following the JSON Pointer
  // Returns the resolved schema or null if not found
}
```

### 3. Enhanced Semantic Validation
Updated `_validateAllOfSemantics()` to resolve references before checking types:

```dart
for (var i = 0; i < schemas.length; i++) {
  if (schemas[i] is Map) {
    Map schema = schemas[i] as Map;

    // Try to resolve reference if document is provided
    if (schema.containsKey(r'$ref') && document != null) {
      final ref = schema[r'$ref'] as String;
      final resolvedSchema = _resolveInternalReference(ref, document);
      if (resolvedSchema != null) {
        schema = resolvedSchema;  // Use resolved schema
      }
    }

    // Now collect types from both inline and resolved schemas
    if (schema.containsKey('type') && schema['type'] is String) {
      types.add(schema['type'] as String);
    }
  }
}
```

## Test Results

### Before Fix
```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_allof_incompatible_types.yaml
✓ Validation successful: OpenAPI 3.0.0 specification is valid  # WRONG!
```

### After Fix
```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_allof_incompatible_types.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidAllOfIncompatibleTypes/allOf: 
allOf contains schemas with incompatible types (string, object). 
An instance cannot simultaneously be of multiple incompatible types. 
(See: JSON Schema Core - Section 10.2.1.1 (allOf))
```

## Benefits

1. **Complete Semantic Validation**: Now detects semantic errors in `allOf` whether schemas are inline or referenced
2. **Backward Compatible**: The `document` parameter is optional - validation works without it (just skips reference resolution)
3. **Proper Error Detection**: Catches impossible-to-satisfy schemas at validation time rather than runtime
4. **Works with Real-World Schemas**: The original `main.yaml` file that references `inventory_alert.yaml` now correctly reports the error

## Scope

The reference resolution currently handles:
- ✅ Internal references (e.g., `#/components/schemas/Pet`)
- ✅ Component schemas in the same document
- ✅ Type checking across references
- ✅ Enum intersection checking across references
- ✅ Const value checking across references

**Not handled** (by design):
- ❌ External file references (e.g., `pet.yaml#/Dog`) - these are validated separately
- ❌ Circular reference detection (would require more complex tracking)
- ❌ Deep transitive reference chains (only resolves one level)

## Files Modified

1. **schema_object_validator.dart** (~50 lines added/modified)
   - Added `document` parameter throughout
   - Added `_resolveInternalReference()` method
   - Enhanced `_validateAllOfSemantics()` with resolution

2. **openapi_object_validator.dart** (2 lines modified)
   - Passes document to components validator

3. **components_object_validator.dart** (3 lines modified)
   - Accepts and passes document to schema validator

## Validation Coverage

All test cases pass correctly:

| Test Case | Expected | Result |
|-----------|----------|--------|
| Valid composition schemas | ✓ Pass | ✓ Pass |
| Empty allOf array | ✗ Fail | ✗ Fail |
| Incompatible types (inline) | ✗ Fail | ✗ Fail |
| **Incompatible types (with ref)** | **✗ Fail** | **✗ Fail** ✨ |
| Disjoint enums | ✗ Fail | ✗ Fail |
| Discriminator without composition | ✗ Fail | ✗ Fail |
| Duplicate references | ✗ Fail | ✗ Fail |

✨ **This was the broken case - now fixed!**


# Property-Level Conflict Detection in allOf

## Overview
Enhanced semantic validation for `allOf` to detect **property-level conflicts** when merging object schemas. This catches impossible-to-satisfy schemas where the same property is defined with incompatible constraints across multiple schemas in an `allOf`.

## The Problem

### Example: Property Type Conflict
```yaml
InvalidAllOfIncompatibleTypes:
  allOf:
    - type: object
      properties:
        name:
          type: integer
    - $ref: "#/components/schemas/Dog"

Dog:
  type: object
  properties:
    name:
      type: string
```

With `allOf`, an instance must satisfy **ALL** schemas. This means the merged object would need:
- A `name` property that is `type: integer` (from first schema)
- A `name` property that is `type: string` (from Dog schema)

**This is impossible!** A property cannot be both an integer AND a string.

### Why This Matters
Previously, the validator only checked for **schema-level** type conflicts (e.g., one schema says the whole thing is a `string`, another says it's an `object`). It missed **property-level** conflicts where individual properties within objects had incompatible definitions.

## Solution

### Enhanced Validation Logic
The validator now:

1. **Collects all object schemas** in the `allOf` (after resolving references)
2. **Extracts property definitions** from each object schema
3. **Groups properties by name** - if the same property appears in multiple schemas
4. **Validates compatibility** - checks that multiple definitions of the same property are compatible

### What It Detects

#### 1. Property Type Conflicts
```yaml
allOf:
  - type: object
    properties:
      id:
        type: integer
  - type: object
    properties:
      id:
        type: string  # ✗ Conflict: integer vs string
```

**Error**: `allOf contains conflicting type definitions for property "id": integer, string`

#### 2. Property Enum Conflicts
```yaml
allOf:
  - type: object
    properties:
      role:
        enum: ["admin", "user"]
  - type: object
    properties:
      role:
        enum: ["guest", "moderator"]  # ✗ No common value
```

**Error**: `allOf contains conflicting enum values for property "role". The enum constraints have no common value.`

#### 3. Property Const Conflicts (JSON Schema)
```yaml
allOf:
  - type: object
    properties:
      status:
        const: "active"
  - type: object
    properties:
      status:
        const: "inactive"  # ✗ Different const values
```

**Error**: `allOf contains conflicting const values for property "status"`

Note: `const` is from later JSON Schema versions, not in OpenAPI 3.0.0

### What It Allows

#### Compatible Constraints
```yaml
allOf:
  - type: object
    properties:
      age:
        type: integer
        minimum: 0
  - type: object
    properties:
      age:
        type: integer
        maximum: 120
# ✓ Valid: Both define age as integer, constraints are compatible
```

#### Same Type, Different Validations
```yaml
allOf:
  - type: object
    properties:
      name:
        type: string
  - type: object
    properties:
      name:
        type: string
        minLength: 1
# ✓ Valid: Same type, just adding more constraints
```

#### Different Properties
```yaml
allOf:
  - type: object
    properties:
      id:
        type: integer
  - type: object
    properties:
      name:
        type: string
# ✓ Valid: Different properties, no overlap
```

## Implementation Details

### Key Functions

#### `_validateAllOfSemantics()`
Enhanced to collect object schemas and call property validation:
```dart
// Collect object schemas for property-level validation
if (schema.containsKey('type') && schema['type'] == 'object') {
  objectSchemas.add(schema);
}

// Check for property-level conflicts in object schemas
if (objectSchemas.length > 1) {
  _validateAllOfPropertyConflicts(objectSchemas, path);
}
```

#### `_validateAllOfPropertyConflicts()`
New function that:
1. Extracts all property definitions from all object schemas
2. Groups properties by name
3. Validates each property that appears in multiple schemas

#### `_validatePropertyCompatibility()`
New function that checks:
- Type compatibility
- Enum value intersection
- Const value uniqueness

### Reference Resolution
Works seamlessly with the existing reference resolution:
```dart
// Resolve references before checking properties
if (schema.containsKey(r'$ref') && document != null) {
  final ref = schema[r'$ref'] as String;
  final resolvedSchema = _resolveInternalReference(ref, document);
  if (resolvedSchema != null) {
    schema = resolvedSchema;
  }
}
```

This means property conflicts are detected **even when schemas are referenced** rather than inline.

## Test Coverage

| Test Case | Scenario | Result |
|-----------|----------|--------|
| Valid: Same type, added constraints | `age: integer` + `age: integer, max: 120` | ✓ Pass |
| Valid: Different properties | `id: integer` + `name: string` | ✓ Pass |
| Valid: Base + extension | Reference to base + additional properties | ✓ Pass |
| Invalid: Type conflict | `id: integer` + `id: string` | ✗ Fail |
| Invalid: Type conflict via ref | `name: integer` + `$ref: Dog` (name is string) | ✗ Fail |
| Invalid: Enum conflict | `role: [admin, user]` + `role: [guest, moderator]` | ✗ Fail |

## Files Modified

### `schema_object_validator.dart` (~100 lines added)
- Enhanced `_validateAllOfSemantics()` to collect object schemas
- Added `_validateAllOfPropertyConflicts()` - extracts and groups properties
- Added `_validatePropertyCompatibility()` - validates property definitions

## Benefits

1. **Catches Real Bugs**: Detects impossible-to-satisfy schemas at validation time
2. **Works with References**: Resolves `$ref` to check properties across schemas
3. **Clear Error Messages**: Specifies exactly which property and what the conflict is
4. **Spec Compliant**: Aligns with JSON Schema Core's `allOf` semantics
5. **Developer-Friendly**: Prevents schema errors that would cause runtime issues

## Example Error Output

```bash
$ dart run bin/openapi_analyzer.dart validate -f bin/test_invalid_allof_incompatible_types.yaml
✗ Validation failed:
Validation error at components/schemas.InvalidAllOfIncompatibleTypes/allOf: 
allOf contains conflicting type definitions for property "name": integer, string. 
A property cannot have multiple incompatible types across allOf schemas. 
(See: JSON Schema Core - Section 10.2.1.1 (allOf))
```

The error message clearly identifies:
- Where the problem is (`components/schemas.InvalidAllOfIncompatibleTypes/allOf`)
- What the problem is (conflicting type definitions for property "name")
- What the conflict is (integer vs string)
- Why it's a problem (property cannot have multiple incompatible types)
- Where to find more info (JSON Schema Core spec reference)

## Future Enhancements

Potential additional validations:
- Conflicting `required` constraints
- Incompatible number ranges (e.g., `minimum: 10` + `maximum: 5`)
- Conflicting string patterns
- Nested object property conflicts
- Array item schema conflicts


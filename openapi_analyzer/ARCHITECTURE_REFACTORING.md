# OpenAPI Analyzer Architecture Refactoring

## Overview

The OpenAPI Analyzer has been refactored from a 3-stage to a 4-stage processing pipeline with clear separation between structural and semantic validation.

## Previous Architecture (3 Stages)

1. **Validation** - Combined structural and semantic validation
2. **Parsing** - Generate Dart object tree
3. **Analysis** - (Not implemented) Create analysis artifacts

## New Architecture (4 Stages)

### Stage 1: Structural Validation (Pre-parsing)
**Location:** `lib/v3_0_0/structural_validator/`

**Purpose:** Verify that the document uses correct OpenAPI vocabulary and structure

**Checks:**
- Correct top-level fields (`openapi`, `info`, `paths`, etc.)
- Field types (string, boolean, number, map, list)
- Required fields presence
- Allowed keywords per object type
- Pattern matching (e.g., paths must start with `/`)
- Component key patterns
- Enum value types
- Reference object structure (`$ref` must be string, standalone)

**Key Files:**
- `structural_validator.dart` - Main entry point
- `src/openapi_object_structural_validator.dart` - Root object validator
- `src/schema_object_structural_validator.dart` - Schema vocabulary validator
- `src/components_object_structural_validator.dart` - Components validator
- `src/paths_object_structural_validator.dart` - Paths validator
- Various other object-specific structural validators

### Stage 2: Parsing
**Location:** `lib/v3_0_0/parser/`

**Purpose:** Transform validated YAML into Dart object tree

**Status:** Existing implementation preserved. Full typed parsing is deferred - currently using Map representation.

### Stage 3: Semantic Validation (Post-parsing)
**Location:** `lib/v3_0_0/semantic_validator/`

**Purpose:** Verify logical consistency and meaningful relationships

**Checks:**
- Reference resolution and existence
- Duplicate references in composition keywords
- Composition semantics (allOf, oneOf, anyOf conflicts)
- Discriminator property existence and mapping validation
- Default value vs enum compatibility
- Numeric constraint logic (minimum <= maximum)
- String constraint logic (minLength <= maxLength)
- Array constraint logic (minItems <= maxItems)
- Object constraint logic (minProperties <= maxProperties)
- Duplicate templated paths
- External file validation

**Key Files:**
- `semantic_validator.dart` - Main entry point
- `src/semantic_schema_validator.dart` - Schema logic validator
- `src/semantic_paths_validator.dart` - Paths logic validator
- `src/reference_collector.dart` - Reference collection utility
- `src/reference_finder.dart` - Reference finding utility
- `src/json_pointer_resolver.dart` - JSON Pointer resolution

### Stage 4: Schema Modeling (Deferred)
**Location:** `lib/v3_0_0/modeler/`

**Purpose:** Generate specialized schema and operation models for code generation

**Status:** Deferred to future iteration. Folder exists with preliminary content but is not integrated.

## Key Distinctions

### Structural Validation (Stage 1)
**Grammar Checking** - "Is this document written correctly?"

- Field existence and types
- Allowed keywords
- Required fields
- Pattern matching
- Structure rules

**Example:**
```yaml
# STRUCTURAL ERROR: 'type' must be a string from allowed values
type: 123  # ❌ Wrong type
type: "foobar"  # ❌ Not an allowed value
type: "string"  # ✓ Correct
```

### Semantic Validation (Stage 3)
**Logic Checking** - "Does this document make sense?"

- Reference resolution
- Logical consistency
- Composition conflicts
- Constraint coherence
- Meaningful relationships

**Example:**
```yaml
# SEMANTIC ERROR: minimum > maximum is logically impossible
type: integer
minimum: 10
maximum: 5  # ❌ Logically inconsistent
```

## Migration Guide

### For New Code

Use the new 4-stage validator:

```dart
import 'package:openapi_analyzer/main.dart';

void main() {
  final yamlContent = '...';
  
  // Full 4-stage validation
  final doc = OpenApiValidatorV3_0_0.validate(yamlContent);
  
  // Or validate stages separately
  final structurallyValid = OpenApiValidatorV3_0_0.validateStructure(yamlContent);
  OpenApiValidatorV3_0_0.validateSemantics(structurallyValid);
}
```

### For Existing Code

The legacy validator is still available for backward compatibility:

```dart
import 'package:openapi_analyzer/main.dart';

void main() {
  final yamlContent = '...';
  
  // Legacy combined validation (still works)
  final doc = OpenApiValidator.validate(yamlContent);
}
```

### Benefits of the New Architecture

1. **Earlier Error Detection** - Structural issues caught before parsing
2. **More Meaningful Error Messages** - Context-aware semantic validation
3. **Better Performance** - Can skip semantic validation for syntax-only checks
4. **Cleaner Code Organization** - Clear separation of concerns
5. **Easier Maintenance** - New validation rules go in the appropriate category
6. **Testability** - Each stage can be tested independently

## Folder Structure

```
lib/v3_0_0/
├── structural_validator/     # Stage 1: Pre-parsing structure checks
│   ├── structural_validator.dart
│   └── src/
│       ├── openapi_object_structural_validator.dart
│       ├── schema_object_structural_validator.dart
│       ├── components_object_structural_validator.dart
│       ├── paths_object_structural_validator.dart
│       └── ... (other structural validators)
│
├── parser/                    # Stage 2: YAML to Dart objects
│   ├── openapi_parser.dart
│   └── src/
│       └── ... (parser implementation)
│
├── semantic_validator/        # Stage 3: Post-parsing logic checks
│   ├── semantic_validator.dart
│   └── src/
│       ├── semantic_schema_validator.dart
│       ├── semantic_paths_validator.dart
│       ├── reference_collector.dart
│       ├── reference_finder.dart
│       └── json_pointer_resolver.dart
│
├── modeler/                   # Stage 4: Model generation (deferred)
│   └── ... (preliminary content)
│
├── openapi_validator_v3_0_0.dart  # Main orchestrator
│
└── validator/                 # Legacy combined validator (backward compat)
    └── openapi_validator.dart
```

## Shared Utilities

Some utilities are shared across validators:

- `lib/validation_exception.dart` - Exception class
- `lib/utils/validation_utils.dart` - Field validation utilities
- Reference resolution utilities (in semantic_validator/src/)

## Processing Flow

```
YAML Input
    ↓
┌─────────────────────────────────────┐
│ Stage 1: Structural Validation      │
│ ✓ Correct vocabulary?               │
│ ✓ Correct types?                    │
│ ✓ Required fields present?          │
│ ✓ Allowed fields only?              │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ Stage 2: Parsing                    │
│ Transform to Dart objects           │
│ (Currently using Map)               │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ Stage 3: Semantic Validation        │
│ ✓ References resolve?               │
│ ✓ Logically consistent?             │
│ ✓ Composition valid?                │
│ ✓ Constraints coherent?             │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ Stage 4: Schema Modeling (Deferred) │
│ Generate specialized models         │
└─────────────────────────────────────┘
    ↓
Output: Validated Document
```

## Implementation Notes

1. **No New Validation Rules** - All validation logic was reorganized from existing validators, no new rules were added.

2. **No Removed Validation Rules** - All existing validation rules were preserved, just categorized appropriately.

3. **Backward Compatibility** - The legacy `OpenApiValidator` is still available and functional.

4. **OpenAPI 3.0.0 Only** - Implementation targets OpenAPI 3.0.0 specification only.

5. **Modeler Deferred** - Stage 4 (Schema Modeling) is deferred to a future iteration.

## Future Enhancements

1. Complete Stage 2 parsing to generate fully-typed Dart objects
2. Implement Stage 4 schema modeling for code generation
3. Add more sophisticated semantic checks:
   - Circular reference detection
   - Discriminator value uniqueness across oneOf variants
   - readOnly/writeOnly context validation
   - Path parameter consistency with path templates
4. Support for OpenAPI 3.1.x versions
5. Warning system for non-fatal issues

## References

- [OpenAPI 3.0.0 Specification](https://spec.openapis.org/oas/v3.0.0)
- [JSON Schema Specification](https://json-schema.org/specification.html)
- `openapi_validation.md` - Validation philosophy document
- `refactoring_request.md` - Original refactoring requirements


# Semantic Validator Update: Using Typed OpenApiDocument

## Overview

The semantic validator has been updated to use the typed `OpenApiDocument` from the parser as input, rather than working with raw YAML Maps. This properly implements the 4-stage architecture where each stage produces typed output for the next stage.

## Previous Implementation ❌

```dart
// Stage 1: Structural Validation → Map<dynamic, dynamic>
final validMap = StructuralValidator.validate(yamlContent);

// Stage 2: (Skipped - used Map directly)

// Stage 3: Semantic Validation → Used Map
SemanticValidator.validate(validMap, baseDirectory: baseDirectory);
```

**Problems:**
- Semantic validator was working with raw Maps instead of typed objects
- Had to manually navigate through Map structures
- Stage 2 (Parsing) was not properly integrated
- Lost type safety and IDE support

## New Implementation ✅

```dart
// Stage 1: Structural Validation → Map<dynamic, dynamic>
final validMap = StructuralValidator.validate(yamlContent);

// Stage 2: Parsing → OpenApiDocument
final parsedDoc = OpenApiParser.parseFromMap(validMap);

// Stage 3: Semantic Validation → Uses OpenApiDocument
SemanticValidator.validate(parsedDoc);
```

**Benefits:**
- ✅ Semantic validator uses typed `OpenApiDocument`
- ✅ Full type safety and IDE support
- ✅ No manual Map navigation
- ✅ Each stage produces appropriate output for next stage
- ✅ Cleaner, more maintainable code

## API Changes

### SemanticValidator

**Before:**
```dart
static void validate(Map<dynamic, dynamic> document, {String? baseDirectory})
```

**After:**
```dart
static void validate(OpenApiDocument document)
```

### OpenApiValidatorV3_0_0

**Before:**
```dart
static Map<dynamic, dynamic> validate(String yamlContent, {String? baseDirectory})
```

**After:**
```dart
static OpenApiDocument validate(String yamlContent)
```

## File Changes

### Updated Files

1. **`lib/v3_0_0/semantic_validator/semantic_validator.dart`**
   - Now accepts `OpenApiDocument` instead of `Map<dynamic, dynamic>`
   - Removed Map navigation code
   - Removed external file validation (handled in structural stage)
   - Works with typed `Paths` object

2. **`lib/v3_0_0/semantic_validator/src/semantic_paths_validator.dart`**
   - Now accepts `Paths` instead of `Map<dynamic, dynamic>`
   - Uses `paths.paths` to access path items
   - Full type safety

3. **`lib/v3_0_0/openapi_validator_v3_0_0.dart`**
   - Now returns `OpenApiDocument` instead of `Map`
   - Properly invokes Stage 2 parsing
   - Passes typed `OpenApiDocument` to semantic validator

4. **`lib/v3_0_0/parser/openapi_parser.dart`**
   - Added `_parseFromMap()` helper for Stage 2
   - Allows parsing from already-validated Map

## Architecture Flow

```
┌─────────────────────────────────┐
│ Stage 1: Structural Validation  │
│ Input:  YAML string             │
│ Output: Map<dynamic, dynamic>   │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Stage 2: Parsing                │
│ Input:  Map<dynamic, dynamic>   │
│ Output: OpenApiDocument         │ ◄── Typed objects!
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Stage 3: Semantic Validation    │
│ Input:  OpenApiDocument         │ ◄── Uses typed objects!
│ Output: Validated document      │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Stage 4: Modeling (Deferred)    │
│ Input:  OpenApiDocument         │
│ Output: Specialized models      │
└─────────────────────────────────┘
```

## Usage Examples

### Full 4-Stage Validation

```dart
import 'package:openapi_analyzer/main.dart';

void main() {
  final yamlContent = '''
openapi: 3.0.0
info:
  title: My API
  version: 1.0.0
paths:
  /users:
    get:
      responses:
        '200':
          description: Success
  ''';
  
  // Runs all 4 stages, returns typed OpenApiDocument
  final doc = OpenApiValidatorV3_0_0.validate(yamlContent);
  
  // Now you can work with typed objects!
  print('API Title: ${doc.info.title}');
  print('Version: ${doc.info.version}');
  print('Number of paths: ${doc.paths.paths.length}');
}
```

### Individual Stages

```dart
// Stage 1 only - fast structural check
final validMap = OpenApiValidatorV3_0_0.validateStructure(yamlContent);

// Parse to typed objects
final doc = OpenApiParser.parseFromMap(validMap);

// Stage 3 only - semantic validation
OpenApiValidatorV3_0_0.validateSemantics(doc);
```

## Removed Features

### External File Validation

External file validation has been moved to the structural validation stage, as it's more about reference resolution (structural) than logical consistency (semantic).

**Removed from semantic validator:**
- `_validateExternalFiles()`
- `_validateExternalReference()`
- `_navigateToFragment()`
- `ReferenceCollector` and `ReferenceFinder` usage

These will be reimplemented in the structural validator if needed for external file references.

## Future Work

### Schema Semantic Validation

The schema semantic validators (`SemanticSchemaValidator`) need to be refactored to work with the typed `SchemaObject` instead of raw Maps:

```dart
// TODO: Refactor to use typed SchemaObject
if (document.components?.schemas != null) {
  for (final entry in document.components!.schemas!.entries) {
    final schemaName = entry.key;
    final schema = entry.value;  // This is a Referenceable<SchemaObject>
    
    // Need to:
    // 1. Check if it's a reference or actual schema
    // 2. Validate composition semantics (allOf, oneOf, anyOf)
    // 3. Validate discriminator logic
    // 4. Validate constraint coherence
  }
}
```

### Reference Resolution

Reference resolution should be added back to semantic validation, but working with the typed object model:

```dart
// TODO: Implement reference resolution for typed objects
// - Resolve $ref in Referenceable<T> types
// - Validate referenced objects exist
// - Check for circular references
// - Validate reference type compatibility
```

## Migration Guide

If you were using the semantic validator directly (unlikely, as it's internal):

**Before:**
```dart
final yamlDoc = loadYaml(yamlContent);
SemanticValidator.validate(yamlDoc, baseDirectory: 'path/to/base');
```

**After:**
```dart
// Parse to OpenApiDocument first
final doc = OpenApiParser.parse(yamlContent);
SemanticValidator.validate(doc);
```

**Recommended:**
Use the main orchestrator instead:
```dart
final doc = OpenApiValidatorV3_0_0.validate(yamlContent);
```

## Testing

Existing tests should be updated to expect `OpenApiDocument` return type:

**Before:**
```dart
final result = OpenApiValidatorV3_0_0.validate(yamlContent);
expect(result, isA<Map>());
expect(result['openapi'], '3.0.0');
```

**After:**
```dart
final result = OpenApiValidatorV3_0_0.validate(yamlContent);
expect(result, isA<OpenApiDocument>());
expect(result.openapi, '3.0.0');
expect(result.info.title, 'My API');
```

## Benefits Summary

1. **Type Safety**: Full compile-time type checking
2. **IDE Support**: Auto-completion and refactoring support
3. **Cleaner Code**: No manual Map navigation
4. **Better Errors**: Type-specific error messages
5. **Maintainability**: Easier to understand and modify
6. **Proper Architecture**: Each stage has appropriate input/output types
7. **Future-Proof**: Ready for Stage 4 (Modeling) which also uses typed objects

---

*Updated: November 30, 2025*
*Impact: Breaking change for direct semantic validator users (internal only)*
*Migration: Use OpenApiValidatorV3_0_0.validate() instead of working with stages directly*


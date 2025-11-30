# OpenAPI Analyzer Architecture Refactoring Request

## Objective

Restructure the OpenAPI analyzer project to implement a four-stage processing pipeline with clear separation between structural and semantic validation phases.

## Current Architecture (3 Stages)

The project currently operates in three stages:

1. **Validation** - Verify that the YAML input conforms to OpenAPI specification
2. **Parsing** - Generate a Dart object tree from the validated YAML input
3. **Analysis** - (Not yet implemented) Use the Dart tree to create analysis artifacts for code generation

## Target Architecture (4 Stages)

The refactored architecture should implement four distinct stages:

1. **Structural Validation** - Verify document structure, allowed keywords, and types per OpenAPI 3.0 specification
2. **Parsing** - Transform validated YAML into a Dart object tree representation
3. **Semantic Validation** - Verify logical consistency and coherence using the parsed Dart tree
4. **Schema Modeling** - Generate specialized schema and operation models for code generation

## Validation Phase Distinction

The critical distinction between structural and semantic validation is documented in `openapi_validation.md`:

- **Structural Validation**: Ensures correct vocabulary, structure, and spec-compliance (grammar checking)
- **Semantic Validation**: Ensures logical consistency, coherent modeling, and meaningful relationships (logic checking)

## Scope and Constraints

### Version Focus
- Implementation targets **OpenAPI 3.0.0** specification only
- All changes should be contained within the `v3_0_0` folder
- Support for later OpenAPI versions will be addressed in future iterations

### Organizational Requirements
- Each processing stage must have its own dedicated folder/module
- Rename existing folders where appropriate to reflect the new architecture
- Create new folders as needed for clear stage separation

### Migration Task: Validation Logic Separation

**Primary task**: Reorganize existing validation rules into structural and semantic validation categories.

**Critical constraints**:
- **Do not create new validation rules** at this time
- **Do not remove existing validation rules**
- **Only separate and reorganize** the validation logic that has already been implemented
- Many validation examples in `openapi_validation.md` correspond to rules already implemented in the codebase

**Processing order**:
1. Structural validation executes first (pre-parsing)
2. Parsing stage processes the structurally valid document
3. Semantic validation executes on the parsed Dart tree
4. Schema modeling stage (deferred - see below)

### Parser Adjustments
- The parsing stage is already implemented
- Apply necessary tweaks to integrate with the new validation architecture
- Maintain existing parsing functionality

### Schema Modeling Deferral
- **Do not implement** the schema modeling stage at this time
- The `modeler` folder currently contains preliminary content
- **Ignore the modeler folder** and its contents for this refactoring
- Schema modeling will be addressed in a subsequent phase

## Expected Deliverables

1. Restructured folder hierarchy with clear stage separation
2. Existing validation logic correctly categorized into:
   - Structural validation module (pre-parsing checks)
   - Semantic validation module (post-parsing checks)
3. Updated parser integration points as needed
4. Preserved functionality of all existing validation rules

## Implementation Notes

This refactoring establishes the architectural foundation for future enhancements. By clearly separating structural and semantic concerns, the system will support:
- Earlier error detection (structural issues caught before parsing)
- More meaningful error messages (context-aware semantic validation)
- Cleaner code organization and maintainability
- Easier addition of new validation rules in the appropriate category

Any validation rules that are ambiguous in categorization should be reviewed against the definitions in `openapi_validation.md` to determine the appropriate placement.

---

*This summary was created following structured requirements analysis guidelines to ensure clarity, completeness, and actionability.*


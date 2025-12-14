# OpenAPI 3.0.0 – Unified Graph Model and Processing Pipeline

This document describes the architecture and processing pipeline of the OpenAPI Analyzer.

The analyzer converts OpenAPI 3.0.0 documents into a unified graph-based model using `OpenApiGraph`. The graph contains two types of nodes:

- **OpenApiNodes** — represent OpenAPI document structure (`OpenApiDocument`, `Operation`, `PathItem`, `Info`, `License`, etc.)
- **SchemaNodes** — represent Schema Objects with progressively resolved semantics

All nodes in the graph are processed through three stages: structural validation (Stage A), child node creation (Stage B), and content creation (Stage C). The final result is a unified graph that supports downstream tooling such as code generators, linters, documentation generators, or higher-level analyzers.

---

# Unified Graph Model

The `OpenApiGraph` is a single graph structure containing:

- **OpenApiNodes**: Maps of node IDs to `OpenApiNode` instances
- **SchemaNodes**: Maps of node IDs to `SchemaNode` instances
- **OpenApiEdges**: Edges connecting OpenAPI nodes to their child nodes (OpenAPI nodes or Schema nodes)
- **StructuralEdges**: Edges representing structural containment relationships between Schema nodes (properties, items, additionalProperties)
- **ApplicatorEdges**: Edges representing composition relationships between Schema nodes (allOf, oneOf, anyOf)

Each node has a unique `NodeId` composed of:
- `document`: The document URI/path
- `relativePath`: The JSON Pointer path within that document
- `absolutePath`: The concatenation of both (unique identifier)

The graph structure allows nodes to reference each other through edges, creating a complete representation of both the OpenAPI document structure and all schema relationships.

---

# Processing Pipeline Overview

Every node in the graph (OpenAPI or Schema) undergoes **three stages** of processing:

```text
Stage A (Structural Validation) → Stage B (Create Child Nodes) → Stage C (Create Content)
```

**Processing Order:**
- **Stage A** and **Stage B** proceed **top-down** (root to leaves) — structural validation and child node creation happen from the root document downward
- **Stage C** proceeds **bottom-up** (leaves to root) — content creation is recursive, with leaf nodes being created first and the root node created last

This ensures that:
- Structural validation catches issues early before graph construction
- All child nodes exist before parent nodes attempt to create their content
- Child node content is fully resolved before parent node content depends on it

---

# Stage A — Structural Validation

Stage A validates the structure of each node *before* any child nodes are created or content is built.

## Objectives

1. Ensure the node's JSON/YAML structure matches the expected shape for its type
2. Validate that all required fields are present
3. Validate that field types are correct (strings, numbers, arrays, objects, etc.)
4. Validate that no unallowed fields and field names are present 
5. For Schema nodes: validate schema keywords are valid and compatible
6. Produce early diagnostics to prevent cascading errors

## Processing Order

Structural validation proceeds **top-down** from the root document:

1. Validate the root `OpenApiDocument` node
2. Validate child nodes as they are encountered during traversal
3. When external `$ref` are encountered, load and validate those documents recursively

For each node:
- Validate its JSON structure matches the expected schema
- Validate keyword types and structures (e.g., `properties` must be an object, `allOf` must be an array)
- Collect validation exceptions for later reporting

## Scope

- Stage A validates the **structural shape** of nodes (syntax-level validation)
- Stage A does **not** validate semantic relationships or constraint satisfiability
- External documents are validated on-demand when `$ref` are encountered

---

# Stage B — Create Child Nodes

Stage B creates all child nodes for each node in the graph. This happens **top-down** after structural validation.

## For OpenAPI Nodes

OpenAPI nodes create their designated child nodes according to the OpenAPI 3.0.0 specification:

- `OpenApiDocument` → creates `Info`, `Paths`, `Components`, `Server[]`, etc.
- `Operation` → creates `Parameter[]`, `RequestBody`, `Response{}`, `Callback{}`, etc.
- `PathItem` → creates `Operation` nodes for each HTTP method
- `MediaType` → creates `SchemaNode` for its schema
- `Components` → creates child nodes for each component type (schemas, responses, etc.)

Edges are created between parent and child nodes using `OpenApiEdge`.

## For Schema Nodes

Schema nodes create two types of child nodes:

### Structural Children

Structural edges represent containment relationships:
- **PropertiesEdge**: Object schema → property schemas (from `properties`)
- **ItemsEdge**: Array schema → items schema (from `items`)
- **AdditionalPropertiesEdge**: Object schema → additionalProperties schema

These edges are stored as `StructuralEdge` instances in the graph.

### Applicator Children

Applicator edges represent composition relationships:
- **AllOfEdge**: Schema → schemas in `allOf` array
- **OneOfEdge**: Schema → schemas in `oneOf` array
- **AnyOfEdge**: Schema → schemas in `anyOf` array

These edges are stored as `ApplicatorEdge` instances in the graph.

### Reference Resolution

When `$ref` is encountered during child node creation:

1. **Internal `$ref`** (e.g., `#/components/schemas/User`):
   - Resolve the JSON Pointer within the current document
   - Create the referenced SchemaNode if it doesn't exist (recursively applying Stage A and Stage B)
   - Create an edge to the referenced node (structural or applicator, as appropriate)

2. **External `$ref`** (e.g., `common.yaml#/components/schemas/Base`):
   - Check if the external document has already been processed
   - If not, load the document and recursively apply Stage A and Stage B to it
   - Create edges to the referenced nodes from the external document
   - Merge nodes and edges into the unified graph

Note: `$ref` does not create special edge types; references are resolved into normal structural or applicator edges.

## Processing Order

Child node creation proceeds top-down:
1. Root node creates its children
2. Each child node creates its children
3. This continues until all nodes in the graph have been created

At the end of Stage B:
- All nodes exist in the graph
- All edges between nodes are established
- The complete graph structure is in place
- No node content has been created yet

---

# Stage C — Create Content

Stage C creates the actual content for each node. This happens **bottom-up** (recursively, leaves first, root last).

## For OpenAPI Nodes

For OpenAPI nodes, Stage C creates the corresponding OpenAPI object:

- `OpenApiDocumentNode` → creates `OpenApiDocument`
- `OperationNode` → creates `Operation`
- `InfoNode` → creates `Info`
- `PathItemNode` → creates `PathItem`
- etc.

The OpenAPI object holds references back to its node and accesses child node content via getters. For example, `Operation.parameters` gets the content from `$node.parametersNodes`.

**After Stage C, OpenAPI nodes are complete** — their content is fully created and the node processing is finished.

## For Schema Nodes

For Schema nodes, Stage C involves **three sub-stages** that progressively build the schema semantics:

### Stage C.I — Raw Schema

Creates a `RawSchema` object containing the raw schema data with primitive types (strings, numbers, lists, maps).

The `RawSchema` is a direct mapping of the JSON Schema structure:
- Raw constraint values (`minimum`, `maximum`, `minLength`, etc.)
- Raw composition arrays (`allOf`, `oneOf`, `anyOf` as lists of maps)
- Raw structural data (`properties` as a map, `items` as a map)
- No type resolution or constraint merging has occurred yet

This provides a foundation for the next stages.

### Stage C.II — Typed Schema

Creates a `TypedSchema` object by determining the schema type and validating atomic constraints. **No composition resolution occurs in this stage** — compositions are resolved in Stage C.III (Effective Schema).

#### Type Classification

Determines the base type(s) of the schema based on the `type` property and type-specific keywords:

- Single types: `IntegerTypedSchema`, `NumberTypedSchema`, `StringTypedSchema`, `ObjectTypedSchema`, `ArrayTypedSchema`, `BooleanTypedSchema`
- Multi-type: `MultiTypeTypedSchema` (only when composition branches in Effective Schema span different base types — determined later)

The type classification establishes the fundamental type category for constraint validation.

#### Atomic Constraint Validation

Validates that all atomic constraints are internally consistent and compatible with the determined type:

- **Numeric constraints**: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`
  - Validates that `minimum <= maximum` (or strict inequality with exclusivity flags)
  - Validates that `multipleOf > 0`
  
- **String constraints**: `minLength`, `maxLength`, `pattern`, `format`
  - Validates that `minLength <= maxLength`
  
- **Array constraints**: `minItems`, `maxItems`, `uniqueItems`
  - Validates that `minItems <= maxItems`
  
- **Object constraints**: `required`, `minProperties`, `maxProperties`
  - Validates that `minProperties <= maxProperties`
  - Validates that `required` properties exist in `properties`
  
- **Value constraints**: `enum`, `const`, `default`
  - Validates that `default` value is compatible with type constraints
  - Validates that `enum` values are compatible with type

This validation ensures each atomic schema is internally consistent before composition resolution occurs in the next stage.

The typed schema represents the schema with its type established and atomic constraints validated, but **without composition resolution** — compositions (`allOf`, `oneOf`, `anyOf`) remain unresolved at this stage.

### Stage C.III — Effective Schema

Creates an `EffectiveSchema` object with fully resolved semantics, including composition resolution and variant analysis.

#### Composition Resolution

Resolves `allOf`, `oneOf`, and `anyOf` by analyzing the applicator graph.

**Branch Enumeration**

For each `SchemaNode S`, traverse its applicator edges and enumerate branches:

- `allOf` adds schemas into a branch (intersection of constraints)
- `oneOf` and `anyOf` introduce branching:
  - each element in `oneOf` / `anyOf` may itself contain compositions and contribute one or more sub-branches
- Nested combinations produce deeper branching trees

A **branch** is a path through this structure, represented as a sequence of SchemaNodes whose constraints are intended to hold together.

**Branch Validation**

Each branch is checked for:

- **Type consistency**: all schemas on the branch must be compatible at the base-type level
- **Constraint compatibility**: 
  - numeric ranges that do not contradict
  - object constraints that do not contradict
  - array and string constraints that can coexist
- **Overall satisfiability**: the branch must represent a non-empty set of valid instances

Branches that fail these checks are discarded as unsatisfiable.

**Pure oneOf Case**

If a SchemaNode:
- has only `oneOf` (no atomic constraints, no `allOf`), and
- all branches associated with a single `oneOf[i]` validate,

then that `oneOf[i]` can be treated as a coherent unit whose semantics are captured by a single effective variant.

**oneOf with Inherited Constraints / Multiple oneOfs**

If a SchemaNode has:
- atomic constraints, or
- `allOf`, or
- multiple `oneOf` occurrences in its applicator graph,

then:
- each validated branch produces a **branch-only schema** (a merged constraint view)
- these branch-only schemas do not correspond to new SchemaNodes
- they are used to inform the semantic interpretation of the original node

**MultiType vs Single-Type**

A SchemaNode is considered **MultiType** only when validated branches span different base types (e.g. integer and string).

- If all valid branches are integer-based → the node remains `IntegerTypedSchema`
- If all valid branches are number-based → the node remains `NumberTypedSchema`
- If all valid branches are string-based → the node remains `StringTypedSchema`
- `MultiTypeTypedSchema` is reserved for mixed-type unions

Multiple `oneOf`s alone do not imply MultiType.

**Branch Merging**

Merge validated branches into the effective schema constraints, incorporating the branch analysis results.

#### Constraint Resolution

Resolves all constraints by:
- Merging atomic constraints with inherited constraints from `allOf`
- Applying branch-level semantics from `oneOf` and `anyOf`
- Establishing the final constraint set for the schema

#### Variant Analysis

Identifies and analyzes variants:

1. **Node-Backed Variants**: Variants that correspond exactly to a specific SchemaNode in the graph

2. **Branch-Only Variants**: Variants that arise from branch enumeration where no single SchemaNode corresponds to that branch (anonymous merged constraints)

3. **Discriminator Variant Priority**:
   - **Primary**: If `oneOf` exists, variants come from the `oneOf` array
   - **Secondary**: If no `oneOf` exists, variants come from schemas that inherit via `allOf`
   - oneOf variants take absolute precedence

4. **Duplicate Detection**: Identifies variants with identical constraint profiles within the same base type

5. **Subsumption Analysis**: Identifies variants where one's constraints are strictly narrower than another's

The effective schema provides the final, semantically resolved representation used by downstream tools.

## Processing Order

Content creation proceeds **bottom-up** (recursively):

1. Leaf nodes (nodes with no children) create their content first
2. Parent nodes wait for all child nodes to complete Stage C
3. Parent nodes then create their content, which may depend on child content
4. This continues recursively until the root node creates its content

For Schema nodes specifically:
- When a SchemaNode's `_createContent()` is called, it:
  1. Recursively ensures all child SchemaNodes have completed their Stage C
  2. Creates `RawSchema` (Stage C.I)
  3. Creates `TypedSchema` (Stage C.II) — determines type and validates atomic constraints (no composition resolution)
  4. Creates `EffectiveSchema` (Stage C.III) — resolves compositions, merges constraints, and analyzes variants (depends on child effective schemas for composition resolution)

This bottom-up approach ensures that child semantics are fully resolved before parent semantics depend on them.

---

# Naming Conventions

Every operation and schema in the analyzer must have a name. Names follow **PascalCase** conventions and are assigned during Stage C (content creation).

## Operation Naming

Every `Operation` object must have a name:

- If the operation has an `operationId`, that value is used as the name.
- If no `operationId` is provided, the name is derived from the path and HTTP verb: `{{path}}{{http_verb}}` in PascalCase.

**Examples:**
- Path `/v2/oauth/token` with `post` → `V2OauthTokenPost`
- Path `/users/{id}` with `get` → `UsersIdGet`
- If `operationId: "getUser"` is provided → `GetUser`

The path-to-name conversion:
- Removes leading slashes
- Converts path segments to PascalCase
- Replaces path parameter syntax (`{id}`) with the parameter name in PascalCase
- Appends the HTTP verb (get, post, put, patch, delete, etc.) in PascalCase

## Schema Naming

Every `SchemaNode` must have a name. The naming follows this priority order:

1. **`title` property**: If the schema has a `title`, that value is used as the name.

2. **Component name**: If the schema is defined in `Components.schemas` (or other component sections), the component key is used as the name.

3. **Operation context**: If the schema is associated with an operation:
   - **Request body schema**: `{{operation name}}Request`
   - **Response schema**: `{{operation name}}{{status code}}Response`

4. **Structural embedding**: If the schema is structurally embedded within a parent schema:
   - **Property schema** (from `properties`): `{{parent name}}{{property name}}`
   - **Field schema** (from `items`, `additionalProperties`, etc.): `{{parent name}}{{field name}}`

The name is stored as a property of the schema and is used by downstream tools to generate appropriate identifiers.

---

# Schema Validation and Error Reporting

Throughout the analysis pipeline, validation exceptions are collected as nodes are processed. The validation system uses severity levels to categorize errors and strictness levels to control which errors cause validation to fail.

## Severity Levels

Three severity levels categorize validation errors:

- **critical**: Schema represents an empty set (no valid instances possible). Always causes validation to fail regardless of strictness level.
- **moderate**: Schema allows only trivial instances (empty array or empty object). Causes validation to fail in strict and moderate modes.
- **low**: Not recommended schema patterns that might cause confusing code generation or indicate poor API design, but don't make the schema technically invalid. Causes validation to fail only in strict mode.

## Error Categories by Severity

### Critical Severity Errors

These errors indicate that a schema is fundamentally invalid:

- **Type Compatibility**: Incompatible explicit types across schemas, type mismatches with properties, or conflicting inferred types
- **Constraint Conflicts**: Numeric, string, array, or object constraints that are impossible to satisfy
- **Reference Issues**: Circular references, missing references, or duplicate references in composition arrays
- **Value Constraints**: Multiple different `const` values, enum constraints with no common values, or default values not in enum
- **Path Issues**: Duplicate templated paths

### Moderate Severity Errors

These errors indicate schemas that only allow trivial instances:

- Incompatible constraints where the schema can only be satisfied by empty arrays or empty objects
- Composition branches that result in unsatisfiable constraints except for edge cases

### Low Severity Errors

These errors indicate technically valid but not recommended patterns:

- **Type Declaration Issues**: Schema missing explicit `type` property, or empty schema with no type-specific properties
- **Property-Type Mismatches**: Schema has explicit type but contains properties from other types

## Strictness Levels

The validation system supports three strictness levels that control which severity levels cause validation to fail:

- **strict**: All severities (critical, moderate, low) cause validation to fail
- **moderate**: Only critical and moderate severities fail validation; low severity issues are reported as warnings
- **permissive**: Only critical severity issues fail validation; moderate and low severity issues are reported as warnings

## Error Collection and Reporting

The validation system collects exceptions during validation and processes them at the end based on the strictness level. This allows validation to continue and find all issues rather than stopping at the first error. Errors are reported with their severity level and can be used by downstream tools for diagnostics and code generation guidance.

---

# Final Output — OpenApiGraph

After all three stages complete, the analyzer produces a single `OpenApiGraph` that contains:

## Graph Structure

- **OpenApiNodes**: Map of all OpenAPI nodes (document, paths, operations, etc.)
- **SchemaNodes**: Map of all schema nodes
- **OpenApiEdges**: Edges connecting OpenAPI nodes
- **StructuralEdges**: Edges representing schema structural relationships
- **ApplicatorEdges**: Edges representing schema composition relationships

## OpenAPI Object Model

- Fully created OpenAPI objects accessible via node content:
  - `OpenApiDocument`
  - `Paths`, `PathItem`, `Operation`
  - `Info`, `License`, `Contact`
  - `Components` with all component types
  - All other OpenAPI 3.0.0 objects

These objects hold references to their nodes and access child content through node references.

## Schema Model

Each SchemaNode contains:

- **RawSchema**: Raw schema data with primitive types
- **TypedSchema**: Schema with resolved types and compositions
- **EffectiveSchema**: Schema with fully resolved semantics, variants, and constraints

All schema relationships are represented through edges in the graph, allowing traversal of structural and composition relationships.

## Complete Semantic Model

The unified graph provides:

- Complete OpenAPI document structure
- All schema definitions with resolved references
- Fully resolved schema semantics (typed and effective)
- Variant information (node-backed and branch-only)
- Duplicate and subsumed variant analysis
- Validation exceptions categorized by severity

This unified model serves as the semantic foundation for:

- Code generation
- Schema visualization
- API modeling tools
- Validation and linting frameworks
- Documentation tooling

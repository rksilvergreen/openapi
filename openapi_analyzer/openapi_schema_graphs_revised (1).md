
# OpenAPI 3.0.0 – Schema Graph, Composition Resolution, and Effective Schema Model

This document describes the architecture and processing pipeline of the OpenAPI Analyzer.

The analyzer converts OpenAPI 3.0.0 documents into a graph-based semantic model, producing an `AnalysisResult` that includes:

- The full OpenAPI object tree (`OpenApiDocument`, `Paths`, `Components`, `Operation`, `RequestBody`, `MediaType`, etc.)
- A graph of typed `SchemaNode`s representing all Schema Objects
- Structural and applicator graphs describing relationships between SchemaNodes
- A fully reference-resolved schema graph (internal and external `$ref`)
- An effective schema graph: `EffectiveSchemaNode`s with resolved constraints and composition semantics
- Variant information (node-backed and branch-only)
- Duplicate and subsumed variant analysis for variants

This representation is intended to support downstream tooling such as code generators, linters, documentation generators, or higher-level analyzers.

---

# Processing Pipeline Overview

The analyzer executes **four stages**, each building upon the previous.  
The output of all stages is the unified `AnalysisResult`.

```text
Stage A → Stage B → Stage C → Stage D → AnalysisResult
```

There is no instance-validation stage.

---

# Stage A — Structural Validation (Syntax-Level)

Stage A validates the OpenAPI document *before* modeling or graph construction.

## Objectives

1. Ensure the input is a **structurally valid OpenAPI 3.0.0 document**.
2. Ensure all Schema Objects have a **valid shape**, including:
   - Allowed keywords
   - Correct keyword types
   - Valid structure for `properties`, `items`, `allOf`, `oneOf`, `anyOf`, `not`
3. Confirm that Schema Objects are safe for graph construction in later stages.
4. Produce early diagnostics to prevent cascading schema errors.

Stage A is applied to:
- The root OpenAPI document
- Any external documents encountered via `$ref`

---

# Stage B — OpenAPI Object Modeling + Schema Graph Construction

Stage B builds the OpenAPI object tree and the SchemaNode graph, and wires them together.

## Part 1 — OpenAPI Object Model

The analyzer constructs strongly typed classes for the OpenAPI document structure, such as:

- `OpenApiDocument`
- `Info`
- `Paths`
- `PathItem`
- `Operation`
- `RequestBody`
- `MediaType`
- `Responses`
- `Components`
- And the other standard OpenAPI 3.0.0 objects

These classes form the OpenAPI AST.

Importantly, these objects **hold references to SchemaNodes** where appropriate. Examples:

- `MediaType` contains a `SchemaNode` reference for its `schema`.
- `Components` contains maps such as `Map<String, SchemaNode>` for `schemas`, `Map<String, SchemaNode>` for parameter schemas, etc.

In other words, the SchemaNode graph is not a detached parallel structure; its roots are reachable from the OpenAPI object model.

## Part 2 — SchemaNode Construction

For every Schema Object encountered in the OpenAPI model:

### 1. Type Classification (pre-node atomic validation)

Determine which typed SchemaNode to create, based on `type` and type-specific keywords:

- `IntegerSchemaNode`
- `NumberSchemaNode`
- `StringSchemaNode`
- `ObjectSchemaNode`
- `ArraySchemaNode`
- `BooleanSchemaNode`
- `MultiTypeSchemaNode` (only when valid composition branches differ in base type)

### 2. SchemaNode Creation

A `SchemaNode` represents the atomic, raw meaning of that schema, independent of composition.  
Each node holds:

- Its `$id` (document URI + JSON Pointer)
- Its raw schema map
- References back into the OpenAPI object model where relevant

### 3. Atomic Constraint Validation (post-node validation)

Once the SchemaNode is created, atomic constraints are validated, for example:

- Numeric: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`
- String: `minLength`, `maxLength`, `pattern`, `format`
- Object: `required`, `minProperties`, `maxProperties`
- Array: `minItems`, `maxItems`, `uniqueItems`

This ensures each atomic schema is internally consistent.  
Type–keyword compatibility checks belong in this stage (not Stage D).

## Part 3 — Structural & Applicator Graphs

Stage B also constructs the structural and applicator graphs between SchemaNodes.

### Structural Edges

Structural edges represent containment:

- Object → property schema (`properties`)
- Object → pattern-property schema (`patternProperties`)
- Object → `additionalProperties` when it is a schema
- Array → `items` schema
- Array → `additionalItems` schema (if used)

These edges define the **structural graph**: how schemas contain other schemas.

### Applicator Edges

Applicator edges represent logical combinators:

- `allOf`
- `oneOf`
- `anyOf`
- `not`

These edges define the **applicator graph**: how schemas are combined logically.

> `$ref` is not modeled as an edge.  
> Reference resolution is handled in Stage C by merging graphs.

At the end of Stage B:

- The OpenAPI object model is fully built.
- SchemaNodes exist for all Schema Objects.
- Structural and applicator edges exist between SchemaNodes, but cross-document references are not yet resolved.

---

# Stage C — Reference Resolution (Internal & External)

Stage C resolves all `$ref` pointers and merges referenced graphs into a single global graph.

## Internal `$ref`

For internal references (e.g. `#/components/schemas/User`):

1. Resolve the JSON Pointer within the current document.
2. Locate the target Schema Object.
3. Link the corresponding SchemaNode into the structural/applicator graph where the `$ref` appeared.
4. Recursively process any `$ref` within the referenced schema.

The same SchemaNode may appear in multiple places in the graph; node identity is preserved.

## External `$ref`

For external references (e.g. another file or URL):

1. Load the referenced document from its URI.
2. Perform Stage A (structural validation) on the external document.
3. Perform Stage B (object modeling + schema graph construction) on the external document.
4. Perform Stage C (reference resolution) on the external document.
5. Merge the resulting nodes and edges into the global graph.

There are no dedicated `$ref` edges in the final model.  
The outcome of Stage C is simply a larger unified graph composed of all SchemaNodes and edges from all involved documents.

---

# Stage D — Composition Resolution & Effective Schema Graph

Stage D computes the semantic meaning of each SchemaNode by analyzing `allOf`, `oneOf`, and `anyOf` in the applicator graph and by building a parallel effective schema graph.

For each `SchemaNode S`:

## Step 1 — Branch Enumeration

Traverse the applicator graph starting at `S` and enumerate branches:

- `allOf` adds schemas into a branch (intersection of constraints).
- `oneOf` and `anyOf` introduce branching:
  - each element in `oneOf` / `anyOf` produces one or more sub-branches.
- nested compositions produce deeper branching trees.

A **branch** is a path through this structure, represented as a sequence of SchemaNodes whose constraints are intended to hold together.

## Step 2 — Branch Validation

Each branch is checked for:

- Type consistency:
  - all schemas on the branch must be compatible at the base-type level.
- Constraint compatibility:
  - numeric ranges that do not contradict,
  - object constraints that do not contradict,
  - array and string constraints that can coexist.
- Overall satisfiability.

Branches that fail these checks are discarded as unsatisfiable.

### Pure oneOf Case

If a SchemaNode:

- has only `oneOf` (no atomic constraints, no `allOf`), and
- all branches associated with a single `oneOf[i]` validate,

then that `oneOf[i]` can be treated as a coherent unit whose semantics are captured by a single effective variant.

### oneOf with Inherited Constraints / Multiple oneOfs

If a SchemaNode has:

- atomic constraints, or
- `allOf`, or
- multiple `oneOf` occurrences in its applicator graph,

then:

- each validated branch produces a **branch-only schema** (a merged constraint view),
- these branch-only schemas do not correspond to new SchemaNodes,
- they are used to inform the semantic interpretation of the original node.

### MultiType vs Single-Type

A SchemaNode is considered **MultiType** only when validated branches span different base types (e.g. integer and string).

- If all valid branches are integer-based → the node remains `IntegerSchemaNode`.
- If all valid branches are string-based → the node remains `StringSchemaNode`.
- MultiTypeSchemaNode is reserved for mixed-type unions.

Multiple `oneOf`s alone do not imply MultiType.

## Step 3 — EffectiveSchemaNode Construction

For every SchemaNode, an `EffectiveSchemaNode` is created.  
This node:

- has the same `$id` as its corresponding SchemaNode,
- is typed in parallel to the SchemaNode:
  - `IntegerEffectiveSchemaNode`
  - `NumberEffectiveSchemaNode`
  - `StringEffectiveSchemaNode`
  - `ObjectEffectiveSchemaNode`
  - `ArrayEffectiveSchemaNode`
  - `BooleanEffectiveSchemaNode`
  - `MultiTypeEffectiveSchemaNode` (for mixed-type unions),
- and contains resolved constraints derived from:
  - the node’s own atomic constraints,
  - inherited constraints via `allOf`,
  - applicable branch-level semantics from `oneOf` and `anyOf`.

EffectiveSchemaNodes form a parallel graph:

- Structural edges between EffectiveSchemaNodes mirror the structural graph between SchemaNodes.
- Applicator edges between EffectiveSchemaNodes mirror the applicator graph semantics, but with resolved constraints.

Every SchemaNode has exactly one corresponding EffectiveSchemaNode.  
EffectiveSchemaNodes are not copies of SchemaNodes; they are the semantic resolution of those nodes.

## Step 4 — Variant Analysis: Node-Backed and Branch-Only Variants

Each SchemaNode’s semantics may involve **variants**:

- **Node-backed variants** — variants whose semantics correspond exactly to a specific SchemaNode in the original graph.  
  These may be represented directly by EffectiveSchemaNodes.

- **Branch-only variants** — variants that arise from branch enumeration where no single SchemaNode corresponds exactly to that branch.  
  These remain anonymous schema summaries (merged constraints), not nodes, and are tracked only as semantic structures.

Variants are grouped by base type for analysis.

## Step 5 — Duplicate and Subsumed Variants

Variants within the same base-type group are compared to identify:

### Duplicates

Two variants are considered duplicates when:

- they share the same base type, and
- they have effectively identical constraint profiles, for example:
  - same numeric interval (`minimum`, `maximum`, exclusivity flags),
  - same required properties set and property schemas,
  - same enums and formats for strings,
  - same array bounds and item semantics.

Duplicate variants can be merged conceptually and reported as such for diagnostic or generator simplification purposes.

### Subsumed Variants

Variant A is subsumed by Variant B when:

- A’s constraints are strictly narrower or equal to B’s, such that:
  - any instance valid for A is also valid for B.

Examples of subsumption:

- Numeric:
  - `[0, 5]` is subsumed by `[0, 10]`.
- Object:
  - if `required_A` is a superset of `required_B`,
  - and each property in A is at least as strict as in B.

Subsumption is used to identify redundant or overly constrained variants that do not add expressive power.  
This information is recorded for diagnostics and may be used by code generators to avoid modeling redundant variants.

---

# Final Output — `AnalysisResult`

After all four stages, the analyzer produces a single `AnalysisResult` that contains:

## OpenAPI Object Model

- The fully modeled OpenAPI object tree:
  - `OpenApiDocument`
  - `Paths`
  - `PathItem`
  - `Operation`
  - `RequestBody`
  - `MediaType`
  - `Responses`
  - `Components`
  - and all other OpenAPI objects.

These objects contain references to SchemaNodes where schemas are used.

## Schema Graph

- A typed `SchemaNode` for every Schema Object in all involved documents.
- Structural edges representing containment relationships.
- Applicator edges representing composition relationships.
- All nodes verified for type and atomic constraint correctness.

## Reference-Resolved Graph

- All internal and external `$ref` resolved.
- All SchemaNodes from all referenced documents merged into one global graph.

## Effective Schema Graph

- An `EffectiveSchemaNode` for every `SchemaNode`.
- Fully resolved constraints for each node.
- Variant structures for node-backed and branch-only variants.
- Duplicate variant detection.
- Subsumed variant detection.

This unified model serves as the semantic foundation for:

- Code generation
- Schema visualization
- API modeling tools
- Validation and linting frameworks
- Documentation tooling

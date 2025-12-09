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

### Scope of Stage A

- Stage A is applied to the **root OpenAPI document** when analysis begins.
- When an **external `$ref`** is encountered later (Stage C), Stage A is then applied to that external document **on demand**, as part of recursive resolution.
- Stage A **does not pre-scan all external documents up front**; they are validated only when actually needed during reference resolution.

Structural validation walks the structural tree of the document (the raw YAML/JSON), not the SchemaNode graph.

---

# Stage B — OpenAPI Object Modeling + Schema Graph Construction

Stage B builds the OpenAPI object tree and the SchemaNode graph, and wires them together as the structural tree is traversed.

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
- `Components` contains maps such as `Map<String, SchemaNode>` for `schemas` and other schema-bearing maps.

In other words, the SchemaNode graph is not a detached parallel structure; its structural roots are reachable from the OpenAPI object model (e.g. via `Components.schemas`, `MediaType.schema`, parameters, request bodies, etc.).

## Part 2 — SchemaNode Construction

As Stage B traverses the structural tree of the document:

- Whenever a Schema Object is encountered, a corresponding `SchemaNode` is created (if it does not already exist).
- The traversal and node creation happen **in one pass** over the structural OpenAPI tree.

For every Schema Object encountered:

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

- Its `$id`, which is the document URI + JSON Pointer / YAML path, for example:  
  `paths/~1v2~1oauth~1token/post/requestBody/content/application~1json/schema`
- Its raw schema map
- References back into the OpenAPI object model where relevant

All `SchemaNode`s are stored in `AnalysisResult.schemaNodes` as:

```text
Map<String /* id */, SchemaNode>
```

### 3. Atomic Constraint Validation (post-node validation)

Once the SchemaNode is created, atomic constraints are validated, for example:

- Numeric: `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum`, `multipleOf`
- String: `minLength`, `maxLength`, `pattern`, `format`
- Object: `required`, `minProperties`, `maxProperties`
- Array: `minItems`, `maxItems`, `uniqueItems`

This ensures each atomic schema is internally consistent.  
Type–keyword compatibility checks belong in this stage (not Stage D).

## Part 3 — Structural & Applicator Graphs

Stage B also constructs the structural and applicator graphs between SchemaNodes as it traverses the document.

### Structural Edges

Structural edges represent containment:

- Object → property schema (`properties`)
- Object → pattern-property schema (`patternProperties`)
- Object → `additionalProperties` when it is a schema
- Array → `items` schema
- Array → `additionalItems` schema (if used)

These edges define the **structural graph**: how schemas contain other schemas.

Each structural edge stores:

- `fromId` — the `$id` of the parent SchemaNode
- `toId` — the `$id` of the child SchemaNode
- metadata such as property name, pattern, or position

All structural edges are stored in:

```text
AnalysisResult.structuralEdges : List<StructuralEdge>
```

### Applicator Edges

Applicator edges represent logical combinators:

- `allOf`
- `oneOf`
- `anyOf`
- `not`

These edges define the **applicator graph**: how schemas are combined logically.

Each applicator edge stores:

- `fromId` — the `$id` of the parent SchemaNode
- `toId` — the `$id` of a schema participating in a composition
- the applicator kind (`allOf`, `oneOf`, `anyOf`, `not`)
- optional index information (e.g. position in the `oneOf` array)

All applicator edges are stored in:

```text
AnalysisResult.applicatorEdges : List<ApplicatorEdge>
```

> `$ref` is not modeled as an edge.  
> When Stage B encounters a `$ref`, it hands control off to Stage C, which resolves and merges references.

At the end of Stage B (for a given document):

- The OpenAPI object model is built for that document.
- SchemaNodes exist for all Schema Objects in that document.
- Structural and applicator edges exist between SchemaNodes.
- Cross-document references may still be unresolved; these are handled in Stage C.

---

# Stage C — Reference Resolution (Internal & External)

Stage C resolves all `$ref` pointers and merges referenced graphs into a single global graph, while avoiding redundant resolution of the same external documents.

The key responsibilities:

- Resolve internal `$ref` to existing or newly created SchemaNodes.
- Resolve external `$ref` recursively and merge their graphs.
- Track which documents have already been resolved to avoid repeated work.

## Internal `$ref`

For internal references (e.g. `#/components/schemas/User`):

1. Resolve the JSON Pointer within the **current document**.
2. If the referenced schema **already has a SchemaNode** in `AnalysisResult.schemaNodes`, reuse that node.
3. If it does not yet have a SchemaNode, create one as in Stage B and add it to the graph.
4. Link that SchemaNode into the structural/applicator graph at the point where the `$ref` was found.
5. Recursively process any `$ref` within the referenced schema as needed.

The same SchemaNode may appear in multiple locations in the graph; node identity is preserved.

## External `$ref`

For external references (e.g. another file or URL):

1. Normalize the URI and check whether the target document has already been resolved.
   - If **yes**, treat the reference as an internal `$ref` into that already-resolved document:
     - Reuse its SchemaNodes and edges as needed.
   - If **no**, proceed:

2. Load the referenced document from its URI.

3. Apply the pipeline **recursively** to the external document:
   - Stage A — structural validation of the external document
   - Stage B — object modeling + schema graph construction for that document
   - Stage C — reference resolution inside that document

4. Record that this document has now been resolved, so subsequent references to the same URI will not repeat Stage A/B/C.

5. Merge the resulting SchemaNodes, structural edges, and applicator edges into the global `AnalysisResult` graph.

### No `$ref` Edges

There are no dedicated `$ref` edges in the final model.  
The outcome of Stage C is:

- A larger unified graph composed of all SchemaNodes and edges from all resolved documents.
- An internal record (not specified here) of which documents/URIs have already been processed.

---

# Stage D — Composition Resolution & Effective Schema Graph

Stage D computes the semantic meaning of each SchemaNode by analyzing `allOf`, `oneOf`, and `anyOf` in the applicator graph and by building a parallel **effective schema graph**.

It proceeds **from structural roots downward** and resolves compositions recursively so that the semantics of child nodes are established before parents.

## Structural Schema Roots

Composition resolution begins from **structural schema roots**, which typically are:

- Schemas referenced from `Components.schemas`
- Schemas attached to request/response bodies (`MediaType.schema`)
- Other schema entry points reachable from the OpenAPI object model

From each structural root, Stage D traverses the applicator graph and resolves compositions in a depth-first manner.

## Recursive Resolution Order

When traversing the applicator graph for a SchemaNode `S`:

- The analyzer first performs composition resolution for its **children** (the schemas pointed to by applicator edges) before resolving `S` itself.
- This “bottom-up” strategy ensures that:
  - All composition semantics for child schemas are known,
  - Then those results “bubble up” through the applicator graph to the parent,
  - Eventually producing resolved semantics for the root node.

In other words, composition resolution proceeds recursively until it converges at each applicator graph root.

## Step 1 — Branch Enumeration

For each `SchemaNode S`, traverse its applicator edges and enumerate branches:

- `allOf` adds schemas into a branch (intersection of constraints).
- `oneOf` and `anyOf` introduce branching:
  - each element in `oneOf` / `anyOf` may itself contain compositions and contribute one or more sub-branches.
- Nested combinations produce deeper branching trees.

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
- If all valid branches are number-based → the node remains `NumberSchemaNode`.
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

Every SchemaNode has exactly one corresponding EffectiveSchemaNode.  
EffectiveSchemaNodes are not copies of SchemaNodes; they are the semantic resolution of those nodes.

## Effective Graph Structure

The effective schema graph mirrors the original graph at the level of node identity but uses its own edge sets:

- `AnalysisResult.effectiveSchemaNodes : Map<String, EffectiveSchemaNode>`
- `AnalysisResult.effectiveStructuralEdges : List<EffectiveStructuralEdge>`
- `AnalysisResult.effectiveApplicatorEdges : List<EffectiveApplicatorEdge>`

Effective structural edges relate EffectiveSchemaNodes in ways that reflect resolved structural semantics.  
Effective applicator edges represent composition relationships between EffectiveSchemaNodes after resolution.

The original structural and applicator edges remain intact for reference to the syntactic structure.

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

- A typed `SchemaNode` for every Schema Object in all involved documents, stored as:

  ```text
  AnalysisResult.schemaNodes : Map<String /* id */, SchemaNode>
  ```

  where each id is the YAML/JSON path of that node (e.g.  
  `paths/~1v2~1oauth~1token/post/requestBody/content/application~1json/schema`).

- Structural edges representing containment relationships:

  ```text
  AnalysisResult.structuralEdges : List<StructuralEdge>
  ```

- Applicator edges representing composition relationships:

  ```text
  AnalysisResult.applicatorEdges : List<ApplicatorEdge>
  ```

## Reference-Resolved Global Graph

- All internal and external `$ref` resolved.
- All SchemaNodes from all referenced documents merged into one global graph.
- An internal record of which external documents/URIs have already been resolved to avoid redundant work.

## Effective Schema Graph

- An `EffectiveSchemaNode` for every `SchemaNode`, stored as:

  ```text
  AnalysisResult.effectiveSchemaNodes : Map<String /* id */, EffectiveSchemaNode>
  ```

- Effective structural and applicator edges:

  ```text
  AnalysisResult.effectiveStructuralEdges : List<EffectiveStructuralEdge>
  AnalysisResult.effectiveApplicatorEdges : List<EffectiveApplicatorEdge>
  ```

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

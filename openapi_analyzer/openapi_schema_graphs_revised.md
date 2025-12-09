
# OpenAPI 3.0.0 – Schema Graph, Composition Resolution, and Effective Schema Model

This document describes the architecture and processing pipeline of the OpenAPI Analyzer.  
It is written using structured, technical language, reorganized for clarity according to the User Request Summary Guidelines.

The analyzer converts OpenAPI 3.0.0 documents into a graph‑based semantic model, producing an `AnalysisResult` containing:

- The full OpenAPI object tree (OpenApiDocument, PathsObject, ComponentsObject, etc.)
- A graph of typed `SchemaNode`s representing all schemas
- Structural and applicator graphs describing relationships between SchemaNodes
- A fully resolved reference graph (internal and external)
- EffectiveSchema graphs representing resolved semantic constraints
- Variant information (node-backed and branch-only variants)
- Duplicate and subsumed variant analysis

This resulting representation is intended to support downstream tasks such as code generation or schema validation tooling.

---

# Processing Pipeline Overview

The analyzer executes **four stages**, each building upon the previous.  
The output of all stages is the unified `AnalysisResult`.

```
Stage A → Stage B → Stage C → Stage D → AnalysisResult
```

---

# Stage A — Structural Validation (Syntax-Level)

This stage validates the OpenAPI document *before* modeling or graph construction.

### Objectives

1. Ensure the input is a **structurally valid OpenAPI 3.0.0 document**.
2. Ensure all Schema Objects have a **valid shape**, including:
   - Keyword correctness  
   - Proper keyword types  
   - Valid structure for `properties`, `items`, `allOf`, `oneOf`, `anyOf`, `not`
3. Confirm that Schema Objects are safe for graph construction in later stages.
4. Produce early diagnostics to prevent cascading schema errors.

Stage A is performed on:
- The root OpenAPI document  
- Any external documents encountered via `$ref`

---

# Stage B — Object Modeling + Schema Graph Construction

This stage creates two parallel models:

1. The **OpenAPI Object Model**
2. The **SchemaNode Graph**

## Part 1 — OpenAPI Object Model

Constructs typed representations of all OpenAPI elements:

- `OpenApiDocument`
- `PathsObject`, `PathItemObject`, `OperationObject`
- `ResponsesObject`, `RequestBodyObject`, etc.
- `ComponentsObject` and nested structures

This forms the full AST of the OpenAPI document.

## Part 2 — SchemaNode Construction

For every Schema Object:

### 1. Type Classification (pre-node atomic validation)

Determine which SchemaNode type to create:

- `IntegerSchemaNode`
- `StringSchemaNode`
- `ObjectSchemaNode`
- `ArraySchemaNode`
- `BooleanSchemaNode`
- `NullSchemaNode`
- `MultiTypeSchemaNode` (only when branches differ in base type)

### 2. SchemaNode Creation

A `SchemaNode` embodies the *atomic, raw meaning* of the schema before composition.

### 3. Atomic Constraint Validation (post-node validation)

Validate atomic constraints such as:

- numeric: `minimum`, `maximum`, `multipleOf`
- string: `minLength`, `maxLength`, `pattern`
- object: `required`, `minProperties`, `maxProperties`
- array: `minItems`, `maxItems`, `uniqueItems`

Ensures each atomic schema is internally consistent.

## Part 3 — Structural & Applicator Graphs

Edges are constructed as follows:

### Structural Edges  
Represent container → contained relationships:
- object → property schema  
- object → pattern-property schema  
- object → additionalProperties schema (if schema)  
- array → items schema  

### Applicator Edges  
Represent logical combinators:
- `allOf`
- `oneOf`
- `anyOf`
- `not`

> **Note:**  
> `$ref` is **not** treated as an edge.  
> Reference resolution occurs in Stage C.

After Stage B:
- All SchemaNodes exist  
- All pre-resolution edges exist  
- The graph is still a set of trees (no cross-document pointers resolved yet)

---

# Stage C — Reference Resolution (Internal & External)

This stage resolves all `$ref` pointers, producing a unified schema graph.

## Internal `$ref`

1. Resolve pointer (e.g., `#/components/schemas/User`)
2. Navigate to the referenced schema
3. Add the referenced SchemaNode and edges into the current graph  
   (A single SchemaNode may appear multiple times)
4. Recursively perform Stage C on referenced schemas

## External `$ref`

1. Load referenced URI (file or URL)
2. Recursively perform:
   - Stage A
   - Stage B
   - Stage C
   on the external document
3. Merge the resulting nodes and edges into the global graph

### Notes

- No `$ref` edges exist in the final model.
- All references are replaced with their resolved SchemaNodes and edges.
- The end result is **one global OpenAPI graph** containing all schemas and edges from all documents.

---

# Stage D — Composition Resolution & Effective Schema Construction

This stage computes the **semantic meaning** of each SchemaNode by analyzing composition (`allOf`, `oneOf`, `anyOf`) across the applicator graph.

For each SchemaNode `S`:

## Step 1 — Branch Enumeration

Enumerate semantic branches through `S`’s applicator graph:

- `allOf` → merges constraints  
- `oneOf` / `anyOf` → branching  
- nested combinations → deeper branching

Each branch represents a potential variant of `S`.

## Step 2 — Branch Validation

Validate each branch for:

- type consistency  
- constraint compatibility  
- logical satisfiability  

### Pure oneOf Case

If a SchemaNode contains:
- only a `oneOf`  
- no atomic properties  
- no allOf  

then a single `oneOf[i]` may collapse into **one variant** *if all of its internal branches are valid*.

### Mixed oneOf + inheritance

If a SchemaNode has atomic constraints, allOf, or multiple oneOfs:
- Each valid branch becomes a **branch-only Schema** (semantic object)
- These **do not** become new SchemaNodes
- They contribute to the semantic interpretation of the node

### MultiType Classification

A SchemaNode becomes `MultiType...` only when **valid branches differ in base type**.

Multiple oneOfs do **not** imply MultiType when all branches share the same base type.

## Step 3 — EffectiveSchemaNode Construction

Each SchemaNode receives a corresponding **EffectiveSchemaNode**, which contains:

- Fully resolved constraints  
- Semantics derived from:
  - its atomic constraints  
  - `allOf` inheritance  
  - applicable branch semantics  

This graph mirrors the original SchemaNode graph, but expresses **semantic** rather than **syntactic** meaning.

## Step 4 — Variant Deduplication & Subsumption

Variants for each SchemaNode include:

- **Node-backed variants**  
  Variants whose semantics correspond exactly to a real SchemaNode

- **Branch-only variants**  
  Semantic constructs produced from validated branches, without `$id`

Variant analysis includes:

### Duplicate Detection

Variants are duplicates when they share:

- the same base type  
- identical constraint profiles  
  (numeric intervals, required properties, patterns, enums, etc.)

### Subsumption Detection

Variant A is subsumed by Variant B when:

- A’s constraints are strictly narrower  
- Examples:
  - Numeric: `[0,5]` is subsumed by `[0,10]`
  - Object: `required_A ⊇ required_B`

These findings are recorded for diagnostics and may support generator optimizations.

---

# Final Output — `AnalysisResult`

After all stages, the analyzer produces:

## Schema Graph
- A typed `SchemaNode` for every schema
- Structural edges
- Applicator edges
- All nodes validated and type-checked

## Reference-Resolved Graph
- All `$ref` resolved (internal and external)
- Fully unified cross-document structure

## Effective Schema Graph
- An `EffectiveSchemaNode` for every `SchemaNode`
- Fully resolved constraints
- Variant sets (node-backed and branch-only)
- Duplicate and subsumed variant classification

## Full OpenAPI Object Model
- Complete representation of the OpenAPI document tree
- All components, paths, operations, responses, etc.

This serves as the semantic foundation for:
- Code generation
- Schema visualization
- Tooling
- Validation frameworks
- Documentation generation

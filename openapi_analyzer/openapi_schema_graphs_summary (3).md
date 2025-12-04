
# OpenAPI 3.0.0 – Complete Schema Graph, Validation Architecture & Typed SchemaNode Design  
### Structural Graphs • Applicator Graphs • $ref Resolution • Typed SchemaNodes • Validation Stages  
_Comprehensive consolidated design document_

---

# 1. Overview

This document provides a unified and **finalized** design for:

- **SchemaNode structure** (including a typed hierarchy)
- **Structural Graphs** (literal AST + resolved structural graph)
- **Applicator Graph** (typed logical-composition edges)
- **$ref resolution** (internal & external)
- **Validation stages** (document-level → semantic-level)
- **Type classification logic**
- **Cycle handling**
- **Atomic vs composed schemas**

Vocabulary is aligned strictly with **OpenAPI 3.0.0**, which uses a constrained subset of JSON Schema Draft 4.

---

# 2. Validation Stages (Pipeline)

Validation is executed in explicit stages.  
**Stage A merges OpenAPI structural validation and Schema Object shape validation.**

```
Stage A → Stage B → Stage C → Stage D → (optional Stage E)
```

---

## Stage A — OpenAPI 3.0.0 Document Validation + Schema Shape Validation  
### (Pre-Graph, No Semantics)

This stage ensures that:

1. The document is a **structurally valid OpenAPI 3.0.0 document**.
2. All Schema Objects are **shaped correctly**, so graph construction is safe.

This stage **does not** perform semantic/type-keyword compatibility.

### 2.1 OpenAPI Document Validation

Checks include:

- `openapi` version is `"3.0.x"`
- Required top-level structure:
  - `info` present
  - `paths` present
- `paths` is an object of operations
- Places expecting Schema Objects contain:
  - either a Schema Object  
  - or a `$ref` object  
  following OpenAPI rules
- `components.schemas` exists if referenced and is object-like

### 2.2 Schema Shape Validation (Still Pre-Graph)

Checks:

- Only **allowed OpenAPI 3.0 Schema Object keywords** are present  
  (`type`, `properties`, `items`, `allOf`, `oneOf`, `anyOf`, `not`,  
  numeric and string-specific constraints, metadata keywords, vendor extensions, etc.)
- Each keyword’s **value shape** is correct:
  - `properties`: object
  - `patternProperties`: object (if used)
  - `items`: Schema Object or `$ref`-object
  - `additionalProperties`: boolean or Schema Object / `$ref`
  - `required`: array of strings
  - `allOf`, `anyOf`, `oneOf`: arrays
  - `$ref`: string

Semantic/type compatibility is **not validated here**.  
E.g., `type: integer` + `minLength: 5` is allowed at this stage.

**Result of Stage A:**  
All Schema Objects are structurally well-formed and safe to convert into SchemaNodes.

---

# 3. Stage B — Graph Indexing (SchemaNodes + Edges)

After Stage A passes:

### 3.1 Create Typed SchemaNodes  
Before creating a node, we run the **Type Classification Algorithm** (defined below).  
Based on the classification, we create one of:

- `ObjectSchemaNode`
- `ArraySchemaNode`
- `StringSchemaNode`
- `IntegerSchemaNode`
- `NumberSchemaNode`
- `BooleanSchemaNode`
- `UnknownSchemaNode` (only generic metadata fields, no type & no type-specific keywords)

### 3.2 Extract Structural Edges

Structural relationships come from:

- `properties`
- `patternProperties`
- `items`
- `additionalProperties` (when schema, not boolean)

These become:

```ts
type StructuralKind = "property" | "patternProperty" | "additionalProperties" | "items";

interface StructuralEdge {
  from: SchemaId;
  to: SchemaId;
  kind: StructuralKind;
  key?: string;
  sourcePath: string;
}
```

### 3.3 Extract Applicator Edges (Raw)

Applicators in OpenAPI 3.0.0:

- `allOf`
- `anyOf`
- `oneOf`
- `not`

Before `$ref` resolution, we store them as:

```ts
type ApplicatorKind = "allOf" | "anyOf" | "oneOf" | "not";

interface ApplicatorEdge {
  from: SchemaId;
  to?: SchemaId;  // resolved in Stage C
  kind: ApplicatorKind;
  index?: number;
  sourcePath: string;
}
```

### 3.4 Record Raw `$ref`

We don't resolve yet; we only capture:

- pointer string  
- node where it appears  
- source location  

End of Stage B:

- SchemaNodes created
- Literal Structural Graph built
- Raw Applicator Graph built (no `$ref` edges yet)

---

# 4. Stage C — $ref Resolution & Graph Completion

For each `$ref`:

1. Resolve the URI → locate the external/internal document.
2. If document not seen before:
   - Apply **Stage A** (OpenAPI + shape validation)
   - Apply **Stage B** (index nodes + edges)
3. Resolve the JSON Pointer → target SchemaNode
4. Add an ApplicatorEdge:

```ts
kind: "$ref"
```

5. Optionally treat `$ref` edges as structural edges in a **resolved structural graph** (separate view).

After Stage C:

- **Applicator Graph** fully formed (includes `$ref`)
- **Resolved Structural Graph** may contain cycles
- Literal Structural AST remains a tree

---

# 5. Stage D — Semantic / Schema Logic Validation (Post-Graph)

This is where real semantic checks occur.  
Performed on **typed SchemaNodes + graphs**, not raw JSON.

Examples:

- **Type–keyword compatibility**
  - `minLength` on non-string → diagnostic
  - `maximum` on non-number → diagnostic

- **Logical contradictions**
  - Unsatisfiable `allOf` merges
  - `required` fields not present in `properties`, depending on best-practice rules
  - Impossible combinations of object constraints

- **Composition analysis**
  - No attempt to merge schema types inside SchemaNode  
  - Composition meaning is inferred solely from ApplicatorGraph

Stage D does **not** alter SchemaNodes. It only generates diagnostics & validation results.

---

# 6. Stage E — Instance Validation (Optional)

Uses ApplicatorGraph + StructuralGraph + SchemaNode constraints to validate JSON instances.

Cycle handling uses `(schemaId, instanceLocation)` memoization.

---

# 7. Typed SchemaNode Hierarchy

SchemaNodes represent **atomic schema definitions**, not composed ones.

```dart
sealed class SchemaNode {
  final String id;
  final String documentUri;
  final String jsonPointer;
  final Map<String, dynamic> raw;

  SchemaNode(this.id, this.documentUri, this.jsonPointer, this.raw);
}
```

Concrete subclasses:

```dart
class ObjectSchemaNode extends SchemaNode {}
class ArraySchemaNode extends SchemaNode {}
class StringSchemaNode extends SchemaNode {}
class NumberSchemaNode extends SchemaNode {}
class IntegerSchemaNode extends SchemaNode {}
class BooleanSchemaNode extends SchemaNode {}
class UnknownSchemaNode extends SchemaNode {}
```

**There is no UnionNode, CompositeNode, AnyTypeNode** in OpenAPI 3.0.0 analysis.  
Compositions live exclusively in the Applicator Graph.

---

# 8. Type Classification Algorithm (Finalized)

Given a raw schema `S`:

---

## Step 1 — Check explicit `type`

If present:

- Must be `"object"`, `"array"`, `"string"`, `"number"`, `"integer"`, or `"boolean"`
- If invalid → **throw**
- Create the corresponding typed SchemaNode

Type-specific keywords belonging to other types:

- **ignored semantically**  
- **diagnostic recorded**

Return the typed node.

---

## Step 2 — No explicit type → infer from type-specific keywords

Let:

- `objectKeywords = {properties, additionalProperties, maxProperties, minProperties, required}`
- `arrayKeywords = {items, maxItems, minItems, uniqueItems}`
- `stringKeywords = {maxLength, minLength, pattern}`
- `numberKeywords = {minimum, maximum, exclusiveMinimum, exclusiveMaximum, multipleOf}`
- `integerKeywords = number keywords, but integer expected for instance values`

Determine candidate types:

### Case A — No type-specific keywords

→ `UnknownSchemaNode`

### Case B — Exactly one candidate type

→ Construct that typed node

### Case C — Multiple conflicting candidate types

→ **throw**  
(Conflicting type-specific clues with no explicit type)

---

# 9. Atomic vs Composed Meaning

- SchemaNodes store **atomic** meaning only.
- ApplicatorGraph defines **composition** (`allOf`, `oneOf`, `anyOf`, `not`, `$ref`).
- SchemaNodes do **not** compute combined/merged type or combined constraints.

Composition semantics occur only in Stage D.

---

# 10. Structural Graph Definitions

### 10.1 Literal Structural AST

Derived from:

- `properties`
- `patternProperties`
- `items`
- `additionalProperties` (schema)

This is always a **tree**.

### 10.2 Resolved Structural Graph

Literal structure + `$ref` treated as structural.

May be cyclic.

Used for:

- Code generation  
- Schema exploration  
- Visual models  

---

# 11. Applicator Graph

Applicator edges capture logical relationships:

- `allOf`
- `anyOf`
- `oneOf`
- `not`
- `$ref`

A directed graph. Cycles allowed.

ApplicatorGraph = **all logical/compositional meaning**.

---

# 12. Cycle Handling

### Applicator cycles

Use:

- `(schemaId, instanceLocation)` memoization  
- `inProgress` detection  

Ensures correct recursion handling during evaluation.

### Structural cycles

Only in resolved structural view (via `$ref`).  
Use visited sets to prevent traversal loops.

---

# 13. Architecture Diagram

```
[ Stage A ]
OpenAPI 3.0 Document Validation + Schema Shape Validation
  ↓
[ Stage B ]
Typed SchemaNodes + StructuralEdges + Raw ApplicatorEdges
  ↓
[ Stage C ]
$ref Resolution → Full ApplicatorGraph (+ Resolved Structural Graph)
  ↓
[ Stage D ]
Semantic Validation (type-keyword compatibility, composition analysis)
  ↓
[ Stage E ]
Instance validation (optional)
```

```
            ┌──────────────────────┐
            │   Typed SchemaNode   │
            │ (Object/String/etc.) │
            └──────────────────────┘
                 ↑             ↑
     StructuralEdge        ApplicatorEdge
 (properties/items/etc.)   (allOf/oneOf/ref)
                 │             │
                 ▼             ▼
       Structural Graph     Applicator Graph
        (Tree → Graph)     (Graph, cycles allowed)
```

---

This document now represents the **complete**, **accurate**, and **aligned** model based on all discussions.

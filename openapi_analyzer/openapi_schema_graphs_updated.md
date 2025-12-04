# OpenAPI 3.0.0 – Complete Schema Graph, Validation Architecture & Typed SchemaNode Design
### Structural Graphs • Applicator Graphs • $ref Resolution • Typed SchemaNodes • Validation Stages  
_Comprehensive consolidated design document (with integrated atomic-node validation refinement)_

---

# 1. Overview

This document provides a unified and **finalized** design for:

- **SchemaNode structure** (including a typed hierarchy)
- **Structural Graphs** (literal AST + resolved structural graph)
- **Applicator Graph** (typed logical-composition edges)
- **$ref resolution** (internal & external)
- **Validation stages** (document-level → semantic-level)
- **Type classification logic**
- **Atomic constraint validation** (newly refined)
- **Cycle handling**
- **Atomic vs composed schemas**

Vocabulary is aligned strictly with **OpenAPI 3.0.0**, which uses a constrained subset of JSON Schema Draft 4.

---

# 2. Validation Stages (Pipeline)

Validation is executed in explicit stages:

```
Stage A → Stage B → Stage C → Stage D → (optional Stage E)
```

With the latest refinements:

- **Stage B** now includes **Atomic Constraint Validation**, immediately after creating a typed SchemaNode.
- **Stage D** now exclusively handles **compositional and cross-node semantics**, with no per-node validation.

---

# 3. Stage A — OpenAPI 3.0.0 Document Validation + Schema Shape Validation  
### (Pre-Graph, No Semantics)

Ensures:

1. The document is a **structurally valid OpenAPI 3.0.0 document**.
2. All Schema Objects are **shaped correctly**, ensuring safe graph construction.

This stage includes:

### 3.1 OpenAPI Document Validation
- `openapi` version is `"3.0.x"`
- Required structural fields exist (`info`, `paths`)
- Object locations that expect schemas contain either:
  - a Schema Object, or  
  - a `$ref` object  
- `components.schemas` is well-formed if referenced

### 3.2 Schema Shape Validation
Checks that:

- Only allowed Schema Object keywords appear  
- Each keyword has the **correct shape**:
  - `properties` is an object  
  - `items` is a Schema Object or `$ref`  
  - `additionalProperties` is boolean or schema  
  - `required` is an array of strings  
  - `allOf` / `anyOf` / `oneOf` are arrays  
  - `$ref` is a string  

No semantic/type-keyword compatibility is evaluated here.

**Result:** All schemas are structurally valid and ready for Stage B.

---

# 4. Stage B — Graph Indexing & Typed SchemaNode Construction  
### (Updated with Atomic Constraint Validation)

Stage B now transforms well-formed Schema Objects into fully usable, typed SchemaNodes, validating each node’s internal constraints and extracting graph structure.

The process per schema is:

```
1. Type Classification (raw map)
2. Create typed SchemaNode instance
3. Atomic Constraint Validation (new)
4. Record structural edges
5. Record applicator edges
6. Record raw $ref
```

## 4.1 Type Classification Algorithm

### Explicit `type`
If present:

- Must be `"object"`, `"array"`, `"string"`, `"number"`, `"integer"`, or `"boolean"`
- If invalid → **throw**
- Create corresponding typed SchemaNode
- Any type-specific keywords from other types → ignored, diagnostic recorded

### No explicit `type` → Infer
Inference based on presence of type-specific keywords:

- No clues → `UnknownSchemaNode`
- One type → create that typed node
- Multiple conflicting types → **throw**

## 4.2 Create Typed SchemaNode

Construct one of:

- `ObjectSchemaNode`
- `ArraySchemaNode`
- `StringSchemaNode`
- `NumberSchemaNode`
- `IntegerSchemaNode`
- `BooleanSchemaNode`
- `UnknownSchemaNode`

The node contains:

- id  
- documentUri  
- jsonPointer  
- raw map  
- optionally parsed constraint fields  

## 4.3 Atomic Constraint Validation (NEW)

This step validates **only internal constraints of the node**, independent of composition.

### Examples:

#### String
- `minLength > maxLength`
- invalid `pattern` regex

#### Number / Integer
- `minimum > maximum`
- `multipleOf <= 0`

#### Array
- `minItems > maxItems`

#### Object
- `minProperties > maxProperties`

#### General
- Constraint incompatible with node type (refined after classification)

This step:

- Adds diagnostics  
- Optionally sets `node.isUnsatisfiable = true`  
- Does **not** delete or replace the node  
- Guarantees: **every SchemaNode is semantically valid in isolation** after Stage B

## 4.4 Extract Structural Edges

Derived from:

- `properties`
- `patternProperties`
- `items`
- `additionalProperties` (schema form)

A **literal Structural Graph** is formed, always a tree (pre-$ref).

## 4.5 Extract Applicator Edges (Raw)

From:

- `allOf`
- `oneOf`
- `anyOf`
- `not`

Edges are recorded but unresolved.

## 4.6 Record Raw `$ref`

Stored for Stage C resolution:

- pointer string  
- containing node  
- source path  

---

# 5. Stage C — $ref Resolution & Graph Completion

For each `$ref`:

1. Resolve URI  
2. If external doc not yet processed:
   - Apply Stage A  
   - Apply Stage B  
3. Resolve JSON Pointer to target SchemaNode  
4. Add `$ref` as an ApplicatorEdge  
5. Optionally treat `$ref` as structural (resolved graph)

**Result:**
- Full ApplicatorGraph formed  
- Resolved Structural Graph may contain cycles

---

# 6. Stage D — Semantic Composition & Cross-Node Validation  
### (Updated: no atomic validation here)

Stage D analyzes how SchemaNodes **compose**, never revalidating their internal constraints.

### 6.1 Type–Keyword Compatibility Across Composition
Examples:

- String constraints flowing into a non-string node due to `allOf`
- Number constraints inherited through composition

### 6.2 Logical Contradictions (Cross-Node)
Examples:

- `allOf` combining incompatible ranges from multiple nodes
- Required properties missing after composition
- Conflicts introduced by `not`

### 6.3 Composition Operators
- `allOf` → intersection  
- `oneOf` → exclusivity + validation completeness  
- `anyOf` → satisfiability  
- `not` → negation/anti-satisfaction  

### 6.4 Discriminator Logic

### 6.5 Required Properties Across Inheritance

**Important:**  
Stage D **never** analyzes an atomic node’s internal constraints; those were finalized in Stage B.

---

# 7. Stage E — Instance Validation (Optional)

Uses:

- ApplicatorGraph  
- StructuralGraph  
- Per-node constraints  

Cycles are handled through `(schemaId, instanceLocation)` memoization.

---

# 8. Typed SchemaNode Hierarchy

```dart
sealed class SchemaNode {
  final String id;
  final String documentUri;
  final String jsonPointer;
  final Map<String, dynamic> raw;

  SchemaNode(this.id, this.documentUri, this.jsonPointer, this.raw);

  void validateAtomicConstraints(DiagnosticsSink sink);
}
```

Subclasses:

```dart
class ObjectSchemaNode extends SchemaNode {}
class ArraySchemaNode extends SchemaNode {}
class StringSchemaNode extends SchemaNode {}
class NumberSchemaNode extends SchemaNode {}
class IntegerSchemaNode extends SchemaNode {}
class BooleanSchemaNode extends SchemaNode {}
class UnknownSchemaNode extends SchemaNode {}
```

---

# 9. Atomic vs Composed Meaning

- Nodes store **atomic** meaning  
- Composition stays **external**, in the ApplicatorGraph  
- Atomic validation occurs **only in Stage B**  
- Composition semantics analyzed **only in Stage D**

---

# 10. Structural Graph Definitions

### 10.1 Literal Structural AST  
Tree based on:

- `properties`
- `patternProperties`
- `items`
- `additionalProperties`

### 10.2 Resolved Structural Graph  
Literal structure + `$ref` as structural edges.  
Cycles possible.

---

# 11. Applicator Graph

Contains logical relationships:

- `allOf`
- `anyOf`
- `oneOf`
- `not`
- `$ref`

Directed graph; cycles allowed.

---

# 12. Cycle Handling

### Applicator Cycles
Handled through:

- `(schemaId, instanceLocation)` memoization  
- in-progress detection  

### Structural Cycles
Handled via visited-set traversal.

---

# 13. Updated Architecture Diagram

```
[ Stage A ]
OpenAPI Document + Shape Validation
  ↓
[ Stage B ]
Type Classification
  → Create Typed SchemaNode
  → Atomic Constraint Validation
  → Extract Structural & Applicator Edges
  → Record Raw $ref
  ↓
[ Stage C ]
$ref Resolution → Complete ApplicatorGraph
  ↓
[ Stage D ]
Composition & Cross-Node Semantics
  ↓
[ Stage E ]
Instance Validation (optional)
```

---

This document now reflects your **refined**, **integrated**, and **stable** architecture with atomic-node validation embedded directly into Stage B, and all composition analysis confined to Stage D.

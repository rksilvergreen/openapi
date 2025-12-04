# OpenAPI 3.0.0 – Complete Schema Graph, Validation Architecture & Typed SchemaNode Design
### Structural Graphs • Applicator Graphs • $ref Resolution • Typed SchemaNodes • Validation Stages

---

# 1. Overview
This document defines the architectural model used for analyzing OpenAPI 3.0.0 schemas, resolving structure, performing semantic validation, and describing how composition constructs (`allOf`, `oneOf`, `anyOf`) are interpreted.

It includes:
- Typed SchemaNode hierarchy
- Structural and applicator graphs
- `$ref` resolution model
- Validation stages from syntax to semantic
- Composition branching model
- Cycle-handling guarantees

All terminology aligns with OpenAPI 3.0.0 and its JSON Schema Draft-4–derived semantics.

---

# 2. Validation Stages (Pipeline)

```
Stage A → Stage B → Stage C → Stage D → (optional Stage E)
```

Each stage builds upon the previous, progressively enriching the schema representation and enabling more sophisticated reasoning.

---

# 3. Stage A — OpenAPI Document Validation + Schema Shape Validation

Ensures the document is structurally valid and Schema Objects are shaped correctly, without applying semantic interpretation.

### 3.1 OpenAPI Document Validation
- Ensures required top-level elements are present.
- Validates the positional placement of Schema Objects and `$ref` usage.
- Confirms `paths`, `info`, and referenced `components.schemas` structures.

### 3.2 Schema Shape Validation
Ensures that:
- Only allowed keywords appear in Schema Objects.
- All keywords have values with correct shapes (`object`, `array`, `string`, `$ref`, etc.).
- No semantic assumptions are made here.

After this stage, every schema is safe to convert into SchemaNodes.

---

# 4. Stage B — SchemaNode Construction and Graph Indexing

This stage transforms raw Schema Objects into typed SchemaNodes and extracts structural and applicator relationships.

Processing steps for each schema:

```
1. Type classification
2. Typed SchemaNode creation
3. Atomic constraint validation
4. Structural edge extraction
5. Applicator edge extraction
6. Raw $ref recording
```

### 4.1 Type Classification
Determines the schema’s type using:
- Explicit `type` keyword; or
- Inference from type-specific constraints.

Multiple conflicting inferred types cause an error. Absence of both an explicit type and type-specific constraints yields an `UnknownSchemaNode`.

### 4.2 Typed SchemaNode Creation
Constructs:
- `ObjectSchemaNode`
- `ArraySchemaNode`
- `StringSchemaNode`
- `NumberSchemaNode`
- `IntegerSchemaNode`
- `BooleanSchemaNode`
- `UnknownSchemaNode`

Each node retains:
- Its raw map
- Its document and pointer location
- Its identity within the graph

### 4.3 Atomic Constraint Validation
Each typed SchemaNode is validated in isolation.  
This includes ensuring:
- Numeric ranges are coherent  
- String lengths are coherent  
- Array bounds are coherent  
- Object property limits are coherent  
- Constraints are appropriate for the node’s type  

Diagnostics may be recorded for inconsistent constraints.  
Nodes remain part of the graph even if they contain contradictions.

After this step, each SchemaNode is valid as an independent atomic unit.

### 4.4 Structural Edge Extraction
Edges are created for:
- `properties`
- `patternProperties`
- `items`
- `additionalProperties` when it is a schema

These form the literal structural AST.

### 4.5 Applicator Edge Extraction
Applicator edges are created for:
- `allOf`
- `oneOf`
- `anyOf`
- `not` (if present, though not yet semantically interpreted)

The edges remain unresolved until Stage C.

### 4.6 Recording `$ref`
All `$ref` instances are recorded for deferred resolution.

---

# 5. Stage C — $ref Resolution and Graph Completion

This stage resolves all recorded references.  
For each `$ref`:

1. Resolve target URI.
2. Load external documents (if any) and process them through Stages A and B.
3. Locate the SchemaNode via JSON Pointer.
4. Create a resolved `$ref` applicator edge.
5. Optionally incorporate `$ref` into the resolved structural graph.

The result:
- Complete ApplicatorGraph
- Resolved Structural Graph (possibly cyclic)
- Literal tree preserved separately

---

# 6. Stage D — Semantic Composition and Cross-Node Validation

This stage interprets how SchemaNodes combine through composition constructs.  
Atomic-node validation is already complete, so Stage D focuses only on the semantics of *composed* schemas.

It analyzes:
- Inherited constraints
- Cross-node contradictions
- The logical effects of composition operators

This includes type compatibility, merging of constraints, detection of contradictory requirements, and other semantic issues that arise from structured schema relationships.

---

## 6.x Composition Branching Model

Compositions involving `allOf`, `oneOf`, and `anyOf` introduce multiple possible logical paths through a schema.  
To analyze these paths, composition validation uses a **branch enumeration model**.

### Branch Concept
A **branch** represents one possible interpretation of a composed schema.  
Each branch is formed by:

- Accumulating all constraints introduced by `allOf` along the path, and  
- Following each choice introduced by `oneOf` or `anyOf` into separate logical alternatives.

Each branch therefore contains a **sequence of SchemaObjects** that together represent one coherent scenario.  
Branches are flattened sets of constraints: each schema within a branch must hold simultaneously for that branch to be internally consistent.

### Role of `allOf`
`allOf` contributes schemas that apply to **every** branch passing through the node.  
Constraints from all entries in `allOf` are accumulated sequentially.

### Role of `oneOf` and `anyOf`
Both constructs introduce **branching points**:

- Each item in the array becomes a separate child branch.
- Nested compositions recursively generate further branches.

Although the two constructs have distinct semantics in JSON Schema, they are treated uniformly during branch enumeration.  
Their distinct validation requirements may be applied later, once all branches have been enumerated.

### Satisfiability Rule
A schema composed through `allOf`/`oneOf`/`anyOf` is considered **satisfiable** if **at least one branch** remains internally consistent after constraint accumulation.

If no branch is consistent, diagnostics are raised.  
Branches may still be evaluated further for:
- Redundant compositions  
- Incompatibilities  
- Type conflicts  
- Constraint intersections  

The branching model makes the semantics of nested composition manageable by turning a potentially complex composition graph into a set of linear, analyzable cases.

---

# 7. Stage E — Instance Validation (Optional)

Instance validation uses:
- The ApplicatorGraph
- The StructuralGraph
- Atomic constraints per node
- Composition rules derived from branch analysis

Cycle handling is controlled via `(schemaId, instanceLocation)` memoization.

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
- `ObjectSchemaNode`
- `ArraySchemaNode`
- `StringSchemaNode`
- `NumberSchemaNode`
- `IntegerSchemaNode`
- `BooleanSchemaNode`
- `UnknownSchemaNode`

These nodes hold atomic meaning.  
Composed meaning is handled exclusively through the ApplicatorGraph and the branching model.

---

# 9. Structural Graph Definitions

### Literal Structural AST
Derived directly from structural keywords and always forms a tree.

### Resolved Structural Graph
Includes `$ref` expansion and may contain cycles.  
Useful for generation and schema navigation.

---

# 10. Applicator Graph
Contains all composition and `$ref` relationships.  
Cycles are allowed and resolved through controlled traversal.

---

# 11. Cycle Handling

### Applicator Cycles
Resolved using memoization and in-progress markers.

### Structural Cycles
Handled by visited-set traversal without infinite descent.

---

# 12. Architecture Diagram

```
[ Stage A ]
Syntax + Shape Validation
  ↓
[ Stage B ]
Type Classification
→ Typed SchemaNode Creation
→ Atomic Constraint Validation
→ Structural & Applicator Edge Extraction
→ $ref Recording
  ↓
[ Stage C ]
$ref Resolution → Complete ApplicatorGraph
  ↓
[ Stage D ]
Composition Analysis → Branch Enumeration → Cross-Node Semantics
  ↓
[ Stage E ]
Instance Validation (optional)
```

---

This specification integrates branching-based composition analysis with schema graph construction, ensuring a robust foundation for both design-time and runtime validation.

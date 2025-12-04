# OpenAPI 3.0.0 – Complete Schema Graph & Validation Architecture  
### Structural Graphs • Applicator Graphs • $ref Resolution • SchemaNode Content • Validation Stages  
_Comprehensive consolidated design document_

---

# 1. Overview

This document provides a unified design for:

- **SchemaNode structure** (how schema content is stored)  
- **Structural Graphs** (literal AST + resolved structural graph)  
- **Applicator Graph** (typed logical-composition edges)  
- **$ref resolution** (internal & external, OpenAPI 3.0.0 rules)  
- **Typed edges for structure & logic**  
- **Validation stages** (from document-level checks to semantic/schema logic)  
- **Cycle handling**  

All terminology and keywords are strictly aligned with **OpenAPI 3.0.0**, which uses a subset of JSON Schema Draft 4 vocabulary.

---

# 2. Validation Stages (Pipeline)

We treat validation as a sequence of stages.  
Your preference is to **merge OpenAPI document validation and basic schema-shape validation into a single pre-graph stage**.

## Stage A — OpenAPI 3.0.0 + Schema Shape Validation (Pre-Graph)

This combined stage verifies:

1. The overall **OpenAPI 3.0.0 document** structure.
2. The **basic shape** of all Schema Objects so that graph indexing can safely proceed.

It does **not** perform type–keyword semantic compatibility (e.g. `minLength` vs `type: integer`).  
Its sole purpose is: _“Is everything well-formed enough that we can build graphs without blowing up?”_

### Stage A.1 – OpenAPI 3.0.0 Document Structure

Checks include:

- `openapi` field present and compatible (e.g. `"3.0.x"` string).
- Mandatory top-level fields: `info`, `paths` (and optionally `servers`, `components`, etc.).
- `paths` is an object keyed by path strings; operations (`get`, `post`, etc.) are objects.
- Everywhere a **Schema Object** is expected (e.g. `components.schemas`, `requestBody.content.*.schema`, `responses.*.content.*.schema`), we have:
  - either a Schema Object, or
  - a `$ref` object, per OpenAPI rules.

### Stage A.2 – Schema Object Shape Validation (No Semantics)

For each Schema Object:

- **Allowed keywords** only (OpenAPI 3.0.0 Schema Object subset), e.g.:

  - Numeric: `multipleOf`, `maximum`, `exclusiveMaximum`, `minimum`, `exclusiveMinimum`
  - String: `maxLength`, `minLength`, `pattern`
  - Array: `maxItems`, `minItems`, `uniqueItems`
  - Object: `maxProperties`, `minProperties`
  - General: `required`, `enum`, `type`
  - Composition: `allOf`, `oneOf`, `anyOf`, `not`
  - Structural: `items`, `properties`, `additionalProperties`
  - Misc: `description`, `format`, `default`, `nullable`, `readOnly`, `writeOnly`, `example`, `deprecated`, `xml`
  - Vendor extensions: `x-*` (if allowed)

- **Value shape/type** for structural & applicator keywords (just enough so graphing won’t crash):

  - `properties` must be an object, if present.
  - `patternProperties` (if used) must be an object.
  - `items` must be a schema object or a `$ref`-object, if present.
  - `additionalProperties` must be either:
    - boolean, or
    - a schema object / `$ref`-object.
  - `required` must be an array of strings, if present.
  - `allOf`, `anyOf`, `oneOf` must be arrays (elements are schema objects or `$ref`-objects).
  - `$ref` must be a string, if present.

**Deliberately _not_ checked here:**

- Type–keyword compatibility:
  - `type: integer` + `minLength: 5` is **allowed** at this stage.
  - `type: string` + `minimum: 0` is **allowed** at this stage.

Because these do not prevent us from mapping to `SchemaNode` and building graphs.

Result of Stage A:

> Every Schema Object is structurally well-formed and can be safely turned into `SchemaNode` plus edges.

---

## Stage B — Graph Indexing (SchemaNode + Edges)

Once Stage A passes:

1. **Create SchemaNodes**  
   - For every Schema Object, construct a `SchemaNode` with:
     - `id`, `documentUri`, `jsonPointer`
     - `raw` schema object
     - optional convenience aliases (e.g. `propertiesRaw`, `itemsRaw`, etc.)

2. **Extract StructuralEdges** from:
   - `properties`
   - `patternProperties`
   - `items`
   - `additionalProperties` (when it’s a schema, not a boolean)

3. **Extract ApplicatorEdges (raw)** from:
   - `allOf`, `anyOf`, `oneOf`, `not`  
   (Just record each branch as an edge; `$ref` is not resolved yet.)

4. Record raw `$ref` strings on the nodes that contain them for later resolution.

At the end of Stage B, you have:

- A registry of `SchemaNode`s
- A literal **Structural Graph** (tree-shaped, no `$ref` followed)
- An initial **Applicator Graph** structure (edges for allOf/anyOf/oneOf/not, still with unresolved `$ref` targets)

---

## Stage C — $ref Resolution & Graph Completion

In Stage C, we resolve `$ref` values and complete the graphs.

For each `$ref`:

1. Resolve URI (or relative ref) to a document.
2. If that document hasn’t been processed:
   - Apply Stage A (shape validation) and Stage B (indexing) to it.
3. Resolve JSON Pointer to a target `SchemaNode`.
4. Add an **ApplicatorEdge** with `kind: "$ref"`:
   - `from`: the schema containing the `$ref`
   - `to`: the target schema
5. If you choose to treat `$ref` as structural for shape exploration, add a structural edge in a separate **resolved structural view**.

After Stage C:

- **Applicator Graph**: full directed graph, including `$ref` edges, potentially cyclic.
- **Resolved Structural Graph** (if you use it): structural + `$ref`, also potentially cyclic.
- **Literal Structural AST**: still a tree, unchanged.

---

## Stage D — Semantic / Schema Logic Validation (Post-Graph)

Now that we have SchemaNodes and graphs, we perform deeper semantic checks.

Examples:

- **Type–keyword compatibility**:
  - Warn or error on `minLength` / `maxLength` / `pattern` on non-string types.
  - Warn or error on `minimum` / `maximum` / `multipleOf` on non-number/integer types.

- **Logical / satisfiability checks**:
  - `allOf` branches that cannot be satisfied together.
  - `oneOf` branches that are indistinguishable or overlapping (style warnings).
  - Inconsistent `required` + `properties` + `additionalProperties` combinations.

These checks operate on:

- `SchemaNode` models  
- StructuralGraph + ApplicatorGraph  
- Your Dart (or other language) representations

This stage aligns with your preference to:

> “perform as many tasks as we can on proper Dart classes as opposed to the document json/yaml content.”

---

## Stage E — Instance Validation (Optional)

If you implement instance validation:

- Use ApplicatorGraph + StructuralGraph + SchemaNode content to validate actual JSON instances.
- Handle:
  - `allOf` / `anyOf` / `oneOf` / `not`
  - `additionalProperties`, `items`, `properties`, `required`, etc.
  - Cycles in the ApplicatorGraph via memoization and recursion control.

---

# 3. SchemaNode — Where Schema Content Lives

A `SchemaNode` is the canonical, flat representation of a single schema object.

```ts
interface SchemaNode {
  id: SchemaId;              // "file://openapi.yaml#/components/schemas/User"
  documentUri: string;       // source document URI
  jsonPointer: string;       // JSON Pointer path to this schema

  raw: any;                  // literal schema object as parsed

  // Optional raw aliases (for convenience, still plain JSON, NOT SchemaNode references)
  type?: string | string[];
  propertiesRaw?: Record<string, any>;
  patternPropertiesRaw?: Record<string, any>;
  itemsRaw?: any;
  additionalPropertiesRaw?: any; // if schema, raw object; if boolean, raw boolean
  allOfRaw?: any[];
  anyOfRaw?: any[];
  oneOfRaw?: any[];
  notRaw?: any;
}
```

### Key rule

- Inside `SchemaNode`, **all nested schemas are represented as raw JSON objects**, not as SchemaNodes.
- Graphs (structural & applicator) attach semantics by linking SchemaIds, not by nesting SchemaNodes.

---

# 4. Structural Graphs

## 4.1 Literal Structural AST (Tree)

Structural edges come from:

- `properties`
- `patternProperties`
- `items`
- `additionalProperties` (when a schema)

```ts
type StructuralKind =
  | "property"
  | "patternProperty"
  | "additionalProperties"
  | "items";

interface StructuralEdge {
  from: SchemaId;
  to: SchemaId;
  kind: StructuralKind;
  key?: string;         // property name or regex
  sourcePath: string;   // JSON Pointer to this structural relation
}
```

Literal Structural Graph:

```ts
Map<SchemaId, StructuralEdge[]>
```

- This is a **tree** when you ignore `$ref`.
- Per-document, there are no structural cycles from literal nesting.

---

## 4.2 Resolved Structural Graph (Graph)

If you choose to treat `$ref` as structural during shape exploration:

- Add edges from `$ref` schemas to their targets.
- The graph may contain cycles (recursive schemas).

Used for:

- Code generation
- Introspection of nested properties
- Schema visualizations

Conceptually:

```text
resolvedStructuralEdges = structuralEdges (+ optional refEdges treated as structural)
```

---

# 5. Applicator Graph (Logical Composition)

OpenAPI 3.0.0 applicators:

- `allOf`
- `anyOf`
- `oneOf`
- `not`
- plus `$ref` as logical redirection

```ts
type ApplicatorKind =
  | "allOf"
  | "anyOf"
  | "oneOf"
  | "not"
  | "$ref";

interface ApplicatorEdge {
  from: SchemaId;
  to: SchemaId;
  kind: ApplicatorKind;
  index?: number;       // for array applicators (allOf[i], etc.)
  sourcePath: string;   // JSON Pointer to this occurrence
}
```

Applicator Graph:

```ts
Map<SchemaId, ApplicatorEdge[]>
```

- Always a **directed graph**, not necessarily a tree.
- May contain cycles via `$ref` or mutual allOf compositions.
- Basis for semantic validation and instance validation.

---

# 6. Cycle Handling

## Applicator cycles (logical recursion)

Use:

- A memo table keyed by `(schemaId, instanceLocation)`  
- An `inProgress` set to detect recursive re-entry

This ensures:

- No infinite recursion during validation.
- Correct fixpoint behavior for self-referential schemas.

## Structural cycles (resolved graph)

During resolved structural traversal:

- Track visited `SchemaId`s.
- Do not re-traverse visited nodes.

Literal structural AST is always acyclic.

---

# 7. Why This Separation Matches Your Goals

- Stage A: guarantees **no malformed junk** enters your core model.
- Stage B/C: build **Dart-native** models (SchemaNode + graphs).
- Stage D: performs **semantic and logical validation** on those models rather than raw JSON/YAML.
- Graphs express relationships; SchemaNode expresses content.
- Works equally well for entry and external documents with a single, consistent pipeline.

---

# 8. Architecture Diagram

Overall pipeline:

```text
[ Stage A ]
OpenAPI 3.0 + Schema Shape Validation (doc + schema objects)
  ↓  (produce validated raw schemas)
[ Stage B ]
SchemaNode registry + StructuralEdges + initial ApplicatorEdges
  ↓
[ Stage C ]
$ref resolution → completed ApplicatorGraph (+ resolved StructuralGraph)
  ↓
[ Stage D ]
Semantic/schema logic validation on Dart model + graphs
  ↓
[ Stage E ]
Instance validation (optional)
```

Graphs & nodes:

```text
            ┌──────────────────────┐
            │      SchemaNode      │  ← raw: properties, items, allOf, etc.
            └──────────────────────┘
                 ↑             ↑
     StructuralEdge        ApplicatorEdge
     (properties/items)     (allOf/oneOf/ref)
                 │             │
                 ▼             ▼
         Structural Graph   Applicator Graph
         (Tree → Graph)     (Graph, cycles allowed)
```

This is the consolidated design for your OpenAPI 3.0.0 validator/analyzer.


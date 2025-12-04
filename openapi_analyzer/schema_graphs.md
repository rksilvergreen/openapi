# JSON Schema / OpenAPI Structural & Applicator Graphs

## 1. Overview

In JSON Schema and OpenAPI, there are two fundamentally different graphs that emerge from schema composition:

1. **Structural Schema Graph** — describes _nested schema structure_ via keywords such as `properties`, `items`, `additionalProperties`, etc.
2. **Applicator Graph** — describes _logical validation composition_ via keywords such as `allOf`, `anyOf`, `oneOf`, `not`, and `$ref`.

These graphs serve different purposes, follow different rules, and must be handled with different algorithms.

---

## 2. Structural Schema Graphs

### 2.1 Structural AST (Literal Form)

This is the tree formed by **literal nesting** of schema objects inside structural keywords:

- `properties`
- `items`
- `additionalProperties`
- `prefixItems`
- `contains`
- `propertyNames`
- etc.

Example:

```yaml
type: object
properties:
  user:
    type: object
    properties:
      name: { type: string }
```

This creates the following literal tree:

```
Schema
└── properties.user
      └── properties.name
```

**Properties of the Literal Structural AST:**

- It is always a **tree**.
- `$ref` appears only as a _leaf_ in this tree.
- No cycles are possible from literal structural nesting.

### 2.2 Resolved Structural Graph

When traversing schema **structure for codegen / visualization / property enumeration**, we often follow `$ref` as if its target were structurally nested.

Example:

```yaml
Parent:
  type: object
  properties:
    child:
      $ref: "#/components/schemas/Parent"
```

Following the `$ref` gives:

```
Parent → child → Parent → child → Parent → ...
```

Key points:

- Once `$ref` is expanded, structural traversal becomes a **graph**, not a tree.
- Cycles are possible → **must implement cycle detection**.
- This resolved graph is separate from logical composition (applicators).

### 2.3 Purpose of Structural Graphs

- Determine the shape of objects and arrays.
- Enumerate fields for code generation.
- Provide schema introspection for editors / schema explorers.
- Guide instance traversal during validation.

---

## 3. Applicator Graph

This graph represents **logical composition** of schemas using applicators:

- `allOf`
- `oneOf`
- `anyOf`
- `not`
- `if` / `then` / `else`
- `$ref` (logical redirection to another schema)

Applicators combine schemas using boolean logic.

Example:

```yaml
A:
  allOf:
    - $ref: "#/components/schemas/B"
    - type: string
B:
  allOf:
    - $ref: "#/components/schemas/A"
```

Applicator graph:

```
A → B → A
```

**Properties of the Applicator Graph:**

- It is a **directed graph**.
- Cycles are allowed and common.
- `$ref` contributes edges.
- Must use cycle-detection and memoization during validation.

**Purpose:**

- Defines how constraints combine.
- Drives validation semantics, not structural nesting.

---

## 4. Formal Definitions

### Structural AST (Literal)
A rooted tree defined by:

- Nodes: literal schema objects.
- Edges: `properties`, `items`, `additionalProperties`, etc.
- `$ref` is represented as a leaf node with no expansion.

### Resolved Structural Graph
A directed graph defined by:

- Literal structural edges (from the AST).
- Edges induced by `$ref` expansion.
- May contain cycles.
- Used for structural exploration.

### Applicator Graph
A directed graph defined by:

- Edges created by applicators (`allOf`, `anyOf`, `oneOf`, `not`, …).
- Edges created by `$ref`.
- Represents validation logic.
- May contain cycles.

---

## 5. Algorithms

### 5.1 Traversing the Literal Structural AST

```pseudo
function traverseLiteral(node):
    visit(node)
    for each structuralChild in node.getStructuralChildren():
        traverseLiteral(structuralChild)
```

Note: `$ref` is **not expanded** here.

### 5.2 Traversing the Resolved Structural Graph (Following $ref)

```pseudo
function traverseResolved(node, visited):
    if node in visited:
        return  // cycle detected

    add node to visited
    visit(node)

    for each structuralChild in node.getStructuralChildren():
        traverseResolved(structuralChild, visited)

    if node.hasRef():
        target = resolveRef(node.ref)
        traverseResolved(target, visited)
```

### 5.3 Applicator Graph Traversal

```pseudo
function validate(schema, instance, memo, inProgress):
    key = (schema.id, instance.location)

    if key in memo:
        return memo[key]

    if key in inProgress:
        return true  // break recursion (fixpoint)

    add key to inProgress

    ok = evaluateNonApplicators(schema, instance)

    for each subschema in schema.getApplicators():
        ok = ok AND validate(subschema, instance, memo, inProgress)

    memo[key] = ok
    remove key from inProgress
    return ok
```

---

## 6. Comparison Table

| Graph Type | Shape | Can Cycle? | Includes $ref? | Purpose |
|------------|--------|-------------|----------------|----------|
| **Structural AST (Literal)** | Tree | No | As leaf only | Parsing, static analysis |
| **Resolved Structural Graph** | Directed Graph | Yes | Yes | Structure introspection, codegen |
| **Applicator Graph** | Directed Graph | Yes | Yes | Validation semantics, codegen |

---

## 7. Summary

- `properties` / `items` form a **true tree** in their literal form.
- `$ref` can be treated structurally, but doing so creates a **graph** that may cycle.
- Applicators (`allOf`, `anyOf`, etc.) form a separate **logical composition graph**.
- Proper schema processing requires distinguishing:
  - Literal AST (always a tree)
  - Resolved Structural Graph (graph with cycles)
  - Applicator Graph (validation logic graph with cycles)

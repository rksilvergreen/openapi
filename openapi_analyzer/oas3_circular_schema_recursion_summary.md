
# Circular Schema References in OpenAPI 3.0.0  
### Structural vs Applicator Recursion — Design Notes for an Analyzer / Generator

> **Scope:**  
> - OpenAPI **3.0.0** (also applies to 3.0.x family where schema semantics are the same)  
> - Only **Schema Objects** (no circular refs for paths, parameters, etc.)  
> - Focus on recursion / circular references via:
>   - **Structural positions:** `properties`, `additionalProperties`, `items`
>   - **Applicators:** `allOf`, `oneOf`, `anyOf`, `not`  
> - Perspective: **analyzer / generator** that wants to:
>   - Accept **valid, meaningful recursive schemas**
>   - Detect **unsatisfiable** or **nonsensical** cycles
>   - Avoid infinite loops during `$ref` resolution / validation / codegen


---

## 1. Core Concepts and Mental Model

### 1.1 JSON Reference vs Schema Semantics

In OpenAPI 3.0.0:

- `$ref` follows **JSON Reference**: it just points to another JSON/YAML location.
- Schema meaning comes from **JSON Schema–like semantics** (Draft‑04-ish subset).

A `$ref` cycle is just a cycle in the **document graph**, but whether that cycle is
acceptable depends on **schema semantics**:

- Does the cycle define a **recursive type** with valid instances? ✅  
- Or does it define a schema with **no possible instances** (unsatisfiable)? ❌  
- Or is it a **pure alias loop** with no “real” schema anywhere? ❌


### 1.2 Structural vs Applicator Recursion

We distinguish:

#### Structural recursion

Recursion appears in **structural positions** of a Schema Object:

- `properties` (object fields)
- `items` (array elements)
- `additionalProperties` (map values)

Example:

```yaml
Node:
  type: object
  properties:
    value:
      type: string
    next:
      $ref: '#/components/schemas/Node'
```

Here the schema is recursive **via a property** — a classic linked list node.

#### Applicator recursion

Recursion appears through **applicator keywords** that *combine or constrain schemas*:

- `allOf`
- `oneOf`
- `anyOf`
- `not`

Example:

```yaml
Expr:
  oneOf:
    - type: number
    - type: object
      properties:
        left:
          $ref: '#/components/schemas/Expr'
        right:
          $ref: '#/components/schemas/Expr'
```

Here recursion is via `oneOf`, which chooses between a base case (`number`) and a
recursive case (binary expression).


### 1.3 Satisfiability

A schema is **satisfiable** if there exists at least one **finite JSON instance**
that the schema accepts.

- **Satisfiable recursive schema** → valid, meaningful recursion.  
- **Unsatisfiable recursive schema** → schema that describes **no possible instance**.

Your analyzer should aim to:

1. **Allow** satisfiable recursive schemas.  
2. **Warn or error** on schemas that are provably unsatisfiable.  
3. **Error** on pure alias cycles (`A → B → A`) with no real schema content.  


---

## 2. Structural Recursion Patterns

This section assumes no applicators (`allOf`, `oneOf`, `anyOf`, `not`) yet — only
recursion via `properties`, `items`, and `additionalProperties`.


### 2.1 Objects: `properties`

#### 2.1.1 Valid: optional recursive property

```yaml
components:
  schemas:
    Node:
      type: object
      properties:
        value:
          type: string
        next:
          $ref: '#/components/schemas/Node'
```

- `next` is **optional** (not listed in `required`).
- A valid instance: `{ "value": "tail" }` (no `next` property).
- Instances can be finite linked lists:

  ```json
  { "value": "a", "next": { "value": "b" } }
  ```

**Conclusion:** Satisfiable. This is a canonical recursive object pattern. ✅


#### 2.1.2 Invalid: required recursive property with no base case

```yaml
components:
  schemas:
    Node:
      type: object
      required: [next]
      properties:
        value:
          type: string
        next:
          $ref: '#/components/schemas/Node'
```

Constraints:

- Instance must be an object (`type: object`).
- It must contain a property `next` (`required: [next]`).
- `next` must itself satisfy `Node`, so it must again have `next`, etc.

This demands an **infinite chain** of nested objects. But JSON instances are finite.

**Conclusion:** Unsatisfiable. No finite JSON can satisfy this schema. ❌


#### 2.1.3 Valid: required recursive property with nullable base case

In OpenAPI 3.0.0 we don’t have `type: ["object", "null"]` but we do have `nullable: true`.

```yaml
components:
  schemas:
    Node:
      type: object
      required: [next]
      properties:
        value:
          type: string
        next:
          nullable: true
          allOf:
            - $ref: '#/components/schemas/Node'
```

Interpretation:

- `next` must always be present.
- `next` can be `null`, or an object that satisfies `Node`.

Valid instances:

```json
{ "value": "tail", "next": null }
```

```json
{
  "value": "a",
  "next": {
    "value": "b",
    "next": null
  }
}
```

**Conclusion:** Satisfiable. Recursive, but with a clear base case (`null`). ✅


#### 2.1.4 Valid: optional recursive property with extra constraints

```yaml
components:
  schemas:
    Category:
      type: object
      required: [name]
      properties:
        name:
          type: string
        parent:
          $ref: '#/components/schemas/Category'
```

- `name` is required, `parent` is optional.
- Valid leaf: `{ "name": "Root" }`.
- Valid chain: `{ "name": "Child", "parent": { "name": "Root" } }`.

**Conclusion:** Satisfiable. Classic parent/child relation. ✅


---

### 2.2 Arrays: `items`

#### 2.2.1 Valid: recursive array with optional items (default `minItems = 0`)

```yaml
components:
  schemas:
    NestedArray:
      type: array
      items:
        $ref: '#/components/schemas/NestedArray'
```

- No `minItems`, so `minItems` is effectively **0**.
- Base case: empty array `[]` is valid.
- Recursive cases: `[[]]`, `[[[]]]`, etc.

**Conclusion:** Satisfiable. Infinite family of nested arrays, but finite instances. ✅


#### 2.2.2 Invalid: recursive array with `minItems >= 1` and no base case

```yaml
components:
  schemas:
    NonEmptyNestedArray:
      type: array
      minItems: 1
      items:
        $ref: '#/components/schemas/NonEmptyNestedArray'
```

Constraints:

- Arrays must have **at least one element**.
- Each element must itself satisfy `NonEmptyNestedArray`, so it must be an array with at least one element, and so on.

Like the “required next” object, this requires **infinite depth**.

No finite JSON array can satisfy it.

**Conclusion:** Unsatisfiable. ❌


#### 2.2.3 Valid: recursive array with a base primitive alternative

```yaml
components:
  schemas:
    IntTree:
      type: array
      items:
        oneOf:
          - type: integer
          - $ref: '#/components/schemas/IntTree'
```

Examples of valid instances:

```json
[1, 2, 3]
```

```json
[1, [2, 3], 4]
```

- Recursion is controlled by `oneOf` inside `items`.
- Base case: primitive integer.

**Conclusion:** Satisfiable. Recursive tree-like array. ✅


---

### 2.3 Objects: `additionalProperties`

#### 2.3.1 Valid: recursive map with optional properties

```yaml
components:
  schemas:
    StringTree:
      type: object
      additionalProperties:
        $ref: '#/components/schemas/StringTree'
```

Valid instances:

```json
{}
```

```json
{
  "a": {},
  "b": {
    "c": {}
  }
}
```

- Base case: empty object `{}` is valid; no `minProperties` specified.

**Conclusion:** Satisfiable. Good for JSON-like trees. ✅


#### 2.3.2 Invalid: recursive map with `minProperties >= 1`

```yaml
components:
  schemas:
    NonEmptyStringTree:
      type: object
      minProperties: 1
      additionalProperties:
        $ref: '#/components/schemas/NonEmptyStringTree'
```

Constraints:

- Object must have at least one property.
- Each property value must satisfy `NonEmptyStringTree`.
- So every value must be an object with at least one property, whose value is again such an object, and so on.

Again, infinite descent required.

**Conclusion:** Unsatisfiable. ❌


#### 2.3.3 Valid: recursive map with nullable leaves

```yaml
components:
  schemas:
    StringTreeWithNullLeaves:
      type: object
      additionalProperties:
        oneOf:
          - type: string
          - $ref: '#/components/schemas/StringTreeWithNullLeaves'
```

Examples:

```json
{ "leaf": "value" }
```

```json
{ "a": { "b": "c" } }
```

- Base case: `type: string` branch.

**Conclusion:** Satisfiable. Recursive but with a primitive base case. ✅


---

## 3. Applicator Recursion Patterns

Now we directly use `allOf`, `oneOf`, `anyOf`, `not` — possibly in combination with structural recursion.


### 3.1 `allOf`

`allOf` means logical **AND**: instance must satisfy **every** subschema.

#### 3.1.1 Valid: combine a base schema and a recursive extension

```yaml
components:
  schemas:
    EntityBase:
      type: object
      required: [id]
      properties:
        id:
          type: string
        createdAt:
          type: string
          format: date-time

    TreeNode:
      allOf:
        - $ref: '#/components/schemas/EntityBase'
        - type: object
          properties:
            children:
              type: array
              items:
                $ref: '#/components/schemas/TreeNode'
```

Interpretation:

- Start from `EntityBase`.
- Extend with an optional `children` array of `TreeNode`.

Valid instances:

```json
{ "id": "root", "createdAt": "2024-01-01T00:00:00Z" }
```

```json
{
  "id": "root",
  "createdAt": "2024-01-01T00:00:00Z",
  "children": [
    {
      "id": "child-1",
      "createdAt": "2024-01-02T00:00:00Z"
    }
  ]
}
```

**Recursion is via `items`**, with a clear base case (no children).

**Conclusion:** Satisfiable, valid recursive use of `allOf`. ✅


#### 3.1.2 Valid: `allOf` recursion with nullable child

```yaml
components:
  schemas:
    LinkedItem:
      allOf:
        - type: object
          required: [id]
          properties:
            id:
              type: integer
        - type: object
          properties:
            next:
              nullable: true
              allOf:
                - $ref: '#/components/schemas/LinkedItem'
```

Valid instances:

```json
{ "id": 1, "next": null }
```

```json
{
  "id": 1,
  "next": { "id": 2, "next": null }
}
```

The recursion is nested inside `next` with a nullable base case.

**Conclusion:** Satisfiable. ✅


#### 3.1.3 Invalid: `allOf` with required recursive property and no base case

```yaml
components:
  schemas:
    NonTerminatingNode:
      allOf:
        - type: object
          required: [next]
          properties:
            next:
              $ref: '#/components/schemas/NonTerminatingNode'
```

This is equivalent to the earlier “required `next`” example, simply wrapped in `allOf`.

- `next` is required.
- `next` must itself be another `NonTerminatingNode`.

**Conclusion:** Unsatisfiable. ❌


#### 3.1.4 Invalid: pure alias `allOf` cycle

```yaml
components:
  schemas:
    A:
      allOf:
        - $ref: '#/components/schemas/B'
    B:
      allOf:
        - $ref: '#/components/schemas/A'
```

No schema ever defines any real constraints (no `type`, `properties`, etc.).

- Any attempt to “resolve” `A` leads to `B`, then back to `A`, infinitely.
- There is no substantive schema content anywhere in this SCC (strongly connected component).

**Conclusion:** Your analyzer should flag this as an **unresolvable alias cycle**. ❌


---

### 3.2 `oneOf`

`oneOf` means **exactly one** subschema must match (ignoring how strictly OAS 3.0 enforces “exactly one” — we treat it as such conceptually).

#### 3.2.1 Valid: expression tree

```yaml
components:
  schemas:
    Expr:
      oneOf:
        - $ref: '#/components/schemas/NumberLiteral'
        - $ref: '#/components/schemas/BinaryExpr'

    NumberLiteral:
      type: object
      required: [kind, value]
      properties:
        kind:
          type: string
          enum: ['number']
        value:
          type: number

    BinaryExpr:
      type: object
      required: [kind, left, right]
      properties:
        kind:
          type: string
          enum: ['binary']
        left:
          $ref: '#/components/schemas/Expr'
        right:
          $ref: '#/components/schemas/Expr'
```

- `Expr` is recursive through `BinaryExpr`.
- Base case: `NumberLiteral` (no further recursion).

Valid instance:

```json
{
  "kind": "binary",
  "left": { "kind": "number", "value": 1 },
  "right": { "kind": "number", "value": 2 }
}
```

**Conclusion:** Satisfiable and very common. ✅


#### 3.2.2 Valid: nullable recursive union

```yaml
components:
  schemas:
    RecursiveOrNull:
      oneOf:
        - type: 'null'
        - type: object
          properties:
            next:
              $ref: '#/components/schemas/RecursiveOrNull'
```

- Base case: `null`.
- Recursive case: object with optional `next`.

Valid instances:

```json
null
```

```json
{ "next": null }
```

```json
{ "next": { "next": null } }
```

**Conclusion:** Satisfiable. ✅


#### 3.2.3 Invalid: `oneOf` recursion with no base case

```yaml
components:
  schemas:
    BadExpr:
      oneOf:
        - type: object
          required: [left]
          properties:
            left:
              $ref: '#/components/schemas/BadExpr'
        - type: object
          required: [right]
          properties:
            right:
              $ref: '#/components/schemas/BadExpr'
```

Analysis:

- In **every branch**, `BadExpr` requires another `BadExpr` (`left` or `right` is required and recursive).
- No alternative without recursion.
- No finite instance can terminate the recursion.

**Conclusion:** Unsatisfiable. ❌


#### 3.2.4 Invalid: pure alias `oneOf` cycle

```yaml
components:
  schemas:
    A:
      oneOf:
        - $ref: '#/components/schemas/B'
    B:
      oneOf:
        - $ref: '#/components/schemas/A'
```

Same story as alias cycles in `allOf`.

**Conclusion:** Unresolvable alias cycle. ❌


---

### 3.3 `anyOf`

`anyOf` means the instance must match **at least one** subschema (possibly more).

#### 3.3.1 Valid: tree with primitive or nested structure

```yaml
components:
  schemas:
    IntOrNestedIntArray:
      anyOf:
        - type: integer
        - type: array
          items:
            $ref: '#/components/schemas/IntOrNestedIntArray'
```

Valid instances:

```json
5
```

```json
[1, 2, 3]
```

```json
[1, [2, 3], 4]
```

- Base case: `type: integer`.
- Recursive case: array of `IntOrNestedIntArray`.

**Conclusion:** Satisfiable. ✅


#### 3.3.2 Invalid: `anyOf` recursion with no base case

```yaml
components:
  schemas:
    SelfOnly:
      anyOf:
        - $ref: '#/components/schemas/SelfOnly'
```

This is vacuous: “SelfOnly is valid if it is SelfOnly”. No constraints and no base case.

In practice, some tools interpret this as “no constraints” (i.e. anything is valid), but
from a **well-defined schema design** perspective, your analyzer can treat this as
either:

- Useless recursion → warn.  
- Or alias cycle with no content (if part of a larger SCC) → error.

A more clearly unsatisfiable version:

```yaml
components:
  schemas:
    NonEmptyRecursiveArray:
      anyOf:
        - type: array
          minItems: 1
          items:
            $ref: '#/components/schemas/NonEmptyRecursiveArray'
```

- The only `anyOf` branch still requires infinite recursion.

**Conclusion:** Unsatisfiable. ❌


#### 3.3.3 Valid: combining structural and recursive branches

```yaml
components:
  schemas:
    Shape:
      anyOf:
        - $ref: '#/components/schemas/Circle'
        - $ref: '#/components/schemas/ShapeGroup'

    Circle:
      type: object
      required: [type, radius]
      properties:
        type:
          type: string
          enum: ['circle']
        radius:
          type: number
          minimum: 0

    ShapeGroup:
      type: object
      required: [type, shapes]
      properties:
        type:
          type: string
          enum: ['group']
        shapes:
          type: array
          items:
            $ref: '#/components/schemas/Shape'
```

Valid instances:

```json
{ "type": "circle", "radius": 3 }
```

```json
{
  "type": "group",
  "shapes": [
    { "type": "circle", "radius": 1 },
    {
      "type": "group",
      "shapes": [
        { "type": "circle", "radius": 2 }
      ]
    }
  ]
}
```

- Base case: `Circle`.
- Recursive branch: `ShapeGroup` with array of `Shape`.

**Conclusion:** Satisfiable and realistic. ✅


---

### 3.4 `not`

`not` means “instance must **not** validate against this subschema”. In OAS 3.0’s
limited subset and typical tooling, **recursive use of `not` is almost always a bug**.

#### 3.4.1 Pathological self-recursion

```yaml
components:
  schemas:
    Paradox:
      not:
        $ref: '#/components/schemas/Paradox'
```

Semantics:

- Paradox is valid iff it does **not** validate as Paradox.

This sets up a classical logical contradiction. Under normal, well-founded semantics
this schema is **unsatisfiable** (no instance can be both equal and not equal to itself
under the same predicate).

**Conclusion:** Unsatisfiable. ❌


#### 3.4.2 More “realistic” but still broken example

Suppose someone tries to express “any object that does not contain a forbidden
recursive structure” and messes it up:

```yaml
components:
  schemas:
    SafeNode:
      type: object
      properties:
        id:
          type: string
        child:
          $ref: '#/components/schemas/SafeNode'
        forbidden:
          not:
            $ref: '#/components/schemas/SafeNode'
```

Intended meaning (incorrectly expressed): maybe they wanted `forbidden` to be some
pattern that must **not** be a `SafeNode`, but they recursively use `SafeNode` again.

Analysis:

- If `forbidden` exists and is a `SafeNode`, it fails the `not` (intended).  
- But `SafeNode` itself requires `forbidden` to be… something that is **not** a `SafeNode`.  
- If you try to construct such an object, you fall into a self-referential contradiction:
  `forbidden` must not itself be `SafeNode`, but `SafeNode` includes that same rule.

You end up with either:

- Infinite regress in reasoning, or  
- A requirement that `forbidden` can never be `SafeNode` — which is moot because
  `SafeNode` includes the same rule recursively.

Design‑wise: this is almost always a red flag. Your analyzer can:

- Warn on **any** recursion through `not`.
- Optionally classify them as unsatisfiable when they involve self‑reference or cycles
  within the same SCC that cross a `not` edge.


---

## 4. Combinations of Structural & Applicator Recursion

Most real-life schemas mix structural and applicator recursion.


### 4.1 Discriminated recursive unions

```yaml
components:
  schemas:
    FileSystemEntry:
      oneOf:
        - $ref: '#/components/schemas/File'
        - $ref: '#/components/schemas/Folder'

    File:
      type: object
      required: [kind, name, size]
      properties:
        kind:
          type: string
          enum: ['file']
        name:
          type: string
        size:
          type: integer
          minimum: 0

    Folder:
      type: object
      required: [kind, name, children]
      properties:
        kind:
          type: string
          enum: ['folder']
        name:
          type: string
        children:
          type: array
          items:
            $ref: '#/components/schemas/FileSystemEntry'
```

- Recursion via `items` inside `Folder.children`.
- `oneOf` used to distinguish `File` vs `Folder`.

**Conclusion:** Satisfiable and very common. ✅


### 4.2 `allOf` + structural recursion + nullable base

```yaml
components:
  schemas:
    BaseComment:
      type: object
      required: [id, text]
      properties:
        id:
          type: string
        text:
          type: string

    Comment:
      allOf:
        - $ref: '#/components/schemas/BaseComment'
        - type: object
          properties:
            replies:
              type: array
              items:
                nullable: true
                allOf:
                  - $ref: '#/components/schemas/Comment'
```

Valid instances:

```json
{
  "id": "1",
  "text": "Root comment",
  "replies": [null, null]
}
```

```json
{
  "id": "1",
  "text": "Root comment",
  "replies": [
    {
      "id": "2",
      "text": "Reply",
      "replies": []
    }
  ]
}
```

- Recursion via `items` on `replies`.
- Nullable base for leaf replies.

**Conclusion:** Satisfiable. ✅


### 4.3 Broken combination: required recursive map elements with `allOf`

```yaml
components:
  schemas:
    NonEmptyRecursiveMap:
      allOf:
        - type: object
          minProperties: 1
          additionalProperties:
            $ref: '#/components/schemas/NonEmptyRecursiveMap'
```

This is the same unsatisfiable map example wrapped in `allOf`.

**Conclusion:** Unsatisfiable. ❌


### 4.4 Overly clever `anyOf` that’s actually fine (but tricky)

```yaml
components:
  schemas:
    RecursiveEvent:
      anyOf:
        - $ref: '#/components/schemas/LeafEvent'
        - allOf:
            - $ref: '#/components/schemas/LeafEvent'
            - type: object
              properties:
                children:
                  type: array
                  items:
                    $ref: '#/components/schemas/RecursiveEvent'

    LeafEvent:
      type: object
      required: [type]
      properties:
        type:
          type: string
```

- `RecursiveEvent` is either just a `LeafEvent`, or a `LeafEvent` with `children` of `RecursiveEvent`.
- Base case: simple `LeafEvent`.

**Conclusion:** Satisfiable. ✅  
Your analyzer should **not** over-penalize complex but valid patterns like this.


---

## 5. Heuristics & Algorithms for Your Analyzer

This section gives you practical rules and a rough algorithm for classification.


### 5.1 Build a `$ref` Graph of Schemas

1. Collect all `components.schemas.*`. Each is a **node**.
2. For each Schema Object:
   - For each `$ref` inside it:
     - Add a **directed edge** from this schema to the target schema.
   - Optionally, label edges by context:
     - `structural` (inside `properties`, `items`, `additionalProperties`)
     - `applicator` (inside `allOf`, `oneOf`, `anyOf`, `not`)

3. Find **Strongly Connected Components (SCCs)** in this graph.
   - Each SCC represents a mutually recursive group of schemas.


### 5.2 Classify SCCs

For each SCC (set of schemas that are mutually reachable via `$ref`):

1. Check if **every schema in the SCC is a pure alias**:  
   - i.e. only content is `$ref` (maybe wrapped in trivial `allOf: [ { $ref } ]`).  
   - If true → **Error**: unresolvable alias cycle.

2. Otherwise, at least one schema in the SCC has **real keywords** (`type`, `properties`, `items`, `additionalProperties`, `minimum`, etc.).  
   - This is a **candidate recursive type**.


### 5.3 Analyze for Obvious Unsatisfiability

For each schema in the SCC:

1. Look for patterns like:

   - **Object** with `required` recursive structural property and no base case:
     - `required` includes `p`
     - `properties.p` (or some `allOf` branch) refers back into the SCC  
     - And `p` is not nullable and has no alternative base.

   - **Array** with `minItems >= 1` and `items` referring back into SCC.  
   - **Object** with `minProperties >= 1` and `additionalProperties` referring back.  
   - Recursion crossing a `not` edge back into the same SCC.

2. When you detect such patterns, mark the schema (or SCC) as **unsatisfiable**.

> This is a heuristic: perfect logical satisfiability is complex, but you’ll catch
> most real-world problematic patterns.


### 5.4 Applicator-Specific Rules

- `allOf`:  
  - Fine if at least one branch provides structural content and recursion lives in
    optional or nullable positions.  
  - Suspicious if **all** branches are just `$ref` to within the SCC.

- `oneOf` / `anyOf`:  
  - **Safe** when at least one branch is a **non-recursive base schema** (no `$ref`
    into the SCC).  
  - **Suspicious/unsatisfiable** when **all branches** refer back into the SCC and
    there is no base.

- `not`:  
  - **Warn or error** on any cycle involving `not`.  
  - In practice, self-recursive `not` is almost certainly unsatisfiable or at least
    semantically incoherent.


---

## 6. Decision Table (Schema-Level)

A rough decision aid you can translate into code.


| Question                                                                 | Yes → Next / Result                           | No → Next / Result                               |
|--------------------------------------------------------------------------|-----------------------------------------------|--------------------------------------------------|
| Does the schema (or SCC) contain **only alias-style `$ref`**?           | Mark SCC as **alias cycle error**             | Continue checks                                  |
| Does the schema have any **non-recursive base case branch**?            | Likely **satisfiable** (if no other conflicts)| Check for required/`min*` constraints           |
| Is there a structural recursive property that is **required**?          | Check for nullable / alternative base         | Probably OK (optional recursion)                 |
| Required recursive property has **no nullable/base alternative**?       | Mark as **unsatisfiable**                     | Likely satisfiable                               |
| Array recursion with `minItems >= 1` and no base element type?          | Mark as **unsatisfiable**                     | Likely satisfiable                               |
| Map recursion with `minProperties >= 1` and recursive `additionalProperties` only? | Mark as **unsatisfiable**            | Likely satisfiable                               |
| Does recursion cross a `not` applicator within the SCC?                 | **Warn / mark suspicious or unsatisfiable**   | Probably OK                                      |


---

## 7. Summary for Implementation

1. **Structural vs Applicator recursion:**  
   - Structural recursion (`properties`, `items`, `additionalProperties`) is where most
     valid recursive schemas live.  
   - Applicators (`allOf`, `oneOf`, `anyOf`, `not`) often combine them and can either
     define clean recursive types or produce unsatisfiable schemas.

2. **Valid recursive schemas** always have at least one **base case**:
   - Optional child fields (`parent`, `children` lists).  
   - Nullable pointers (`next: null`).  
   - Primitive or non-recursive union options (`oneOf` / `anyOf`).

3. **Unsatisfiable schemas** typically:
   - Require recursive structures without allowing termination (`required` + recursion,
     `minItems`/`minProperties` + recursion).  
   - Have alias-only cycles with no real schema.  
   - Use `not` in cycles.

4. Your analyzer should:
   - Build a `$ref` graph and find SCCs.  
   - Detect alias-only cycles → error.  
   - Scan recursive schemas for classic unsatisfiable patterns.  
   - Allow and correctly support common recursive patterns used for ASTs, trees, linked
     lists, maps, and nested arrays.

With these rules, your OpenAPI 3.0.0 analyzer/generator will:

- Robustly handle legitimate recursive schemas.  
- Catch many real-world mistakes that would otherwise lead to cryptic runtime errors
  or infinite loops in codegen / validation.

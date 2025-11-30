# OpenAPI Validation: Structural vs. Semantic Validation
### (Design for a Two-Phase Validator)

## Overview

When building an OpenAPI validator, it is natural to split validation into two major phases:

1. **Structural (Spec-Structure) Validation**  
2. **Semantic (Logic) Validation**

These phases mirror the distinction between:

- *“Is this document written using the correct vocabulary and structure?”*  
- *“Given that it’s correctly written, does it **make sense**?”*

This document defines both phases, clarifies naming, and lists what each phase should check.

---

## Phase 1 — Structural (Spec-Structure) Validation

**Goal:**  
Ensure that the OpenAPI document and its schemas use correct **structure**, **allowed keywords**, and **types**, per the OpenAPI 3.0 specification and JSON Schema vocabularies.

This phase answers:

> **“Does this file obey the grammar of OpenAPI and JSON Schema?”**

### What Structural Validation Checks

#### 1. OpenAPI Document-Level Structure
- Correct top-level fields:  
  `openapi`, `info`, `paths`, `servers`, `components`, etc.
- Object-level rules:  
  Only allowed fields per each object type (e.g., `Info Object`, `Operation Object`, `Parameter Object`).
- Patterned fields:  
  - Path keys under `paths` must be valid URL templates.  
  - `components.schemas` keys must map to Schema Objects.
- Reference object rules:  
  - `$ref` must be the **only field** in the object (except `x-` extension fields).  
  - `$ref` must be a valid URI/JSON pointer.

#### 2. JSON Schema Keyword Structure
- Only valid schema keywords may appear:
  `type`, `properties`, `items`, `allOf`, `oneOf`, `anyOf`, `required`, `enum`, `format`, `default`, etc.
- Each keyword must have the correct type:
  - `required`: array of strings  
  - `properties`: object of schemas  
  - `items`: schema or array of schemas  
  - `enum`: non-empty array  
- Keyword-context checks:
  - `properties` only allowed in object schemas  
  - `items` only allowed in array schemas  
  - `minLength`, `pattern` only for strings  
  - `maxItems`, `minItems` only for arrays  

#### 3. OpenAPI-Specific Schema Rules
- `discriminator` object must have only allowed fields (`propertyName`, `mapping`).  
- `nullable`, `readOnly`, `writeOnly` must appear only where allowed.  
- `example`, `examples`, and media-type objects must follow spec rules.

### Summary of Phase 1
This phase ensures:
- All fields are legal and spelled correctly  
- Correct object types  
- Correct schema keyword placement  
- No illegal siblings for `$ref`  
- No structurally invalid combinations

If the document fails this phase, semantic validation is meaningless.

---

## Phase 2 — Semantic (Logic) Validation

**Goal:**  
Ensure the document is **meaningful**, **coherent**, and **logically consistent**.

This phase answers:

> **“Given that the document is well-formed, does it describe a coherent API and correct schema model?”**

### What Semantic Validation Checks

#### 1. Schema Semantics & Consistency
- **Type/keyword coherence**
  - `type: string` with `properties` → nonsensical  
  - `minLength` applied to non-string types  
- **Required vs nullable logic**
  - Required + nullable means “must exist but may be null”  
  - Optional means “may be missing entirely”  
- **Impossible or contradictory constraints**
  - `minimum > maximum`  
  - `minLength > maxLength`  
  - `allOf` combinations that can’t be satisfied  
- **Enum sanity**
  - Enum values match the declared type  
  - No accidental mixed-type enums unless intended

#### 2. Polymorphism & Discriminator Logic
- `discriminator.propertyName` must exist in the schema  
- Each oneOf/anyOf branch must have a unique discriminator value  
- `mapping` values must resolve to actual schemas  
- Detect “meaningless” discriminators:
  - Base schema has a discriminator but is never part of a composition  
- Type consistency:
  - If discriminator values are strings but the property is `type: integer`, flag it unless intentionally allowed

#### 3. Composition Semantics
- `allOf` inheritance:
  - Detect incompatible property overrides  
  - Detect cycles  
- `oneOf` logic:
  - Ensure mutually exclusive schemas  
  - Detect identical branches  
- `anyOf` logic:
  - Ensure at least one branch is satisfiable  
- `not`:
  - Check for contradictions with other constraints

#### 4. Cross-Object & Cross-API Logic
- `$ref` resolution  
  - Existence of referenced schemas  
  - Cyclic references detection (or handling)  
- Path parameter correctness:
  - Every `{id}` in a path must have a corresponding parameter  
  - No duplicate parameters (`name` + `in`)
- Request/response coherence:
  - Response schemas match declared content types  
  - Unintended reuse of schemas for different purposes (lint rule)

#### 5. Project-Level Modeling Rules (Optional)
Examples:
- Disallow `additionalProperties: true`  
- Require `description` on specific elements  
- Enforce naming conventions  
- Enforce `format` usage for integers, UUIDs, etc.  
- Reason about `readOnly` vs `writeOnly`:
  - A property cannot be both  
  - `readOnly` fields required in request bodies → invalid  
  - `writeOnly` fields required in responses → invalid

### Summary of Phase 2
This phase ensures:
- No contradictions  
- Logical, consistent use of polymorphism  
- Proper discriminator usage  
- Reasonable modeling practices  
- Consistency across schema and path definitions

---

## Why These Two Phases Matter

The phases align with how validators work internally:

### **Parsing → Structural Validation → Semantic Validation**

1. **Parsing**:  
   YAML/JSON is syntactically valid.

2. **Structural validation**:  
   Ensures spec rules are followed; fields and objects are valid.

3. **Semantic validation**:  
   Ensures the model is correct, consistent, and meaningful.

If Phase 1 fails → stop early.  
If Phase 2 fails → the document is well-formed but logically defective.

---

## Recommended Terminology

These are the clearest names for future maintainers:

- **Phase 1: Structural / Spec-Structure Validation**  
- **Phase 2: Semantic / Logic Validation**

“Schema validation” is ambiguous—better reserve it for checking a schema against a meta-schema, which is part of Phase 1.

# SQL Standards

## Query Principles

- SQL owns all transactional ground truth
- Queries must remain reproducible and deterministic
- Business logic must be documented at query level
- Avoid hidden transformations
- Preserve transactional granularity in fact tables

---

## Query Header Standard

Every production SQL file must contain:

- Business question
- Analytical purpose
- Key assumptions
- Output grain
- Validation considerations

---

## Naming Standards

- snake_case only
- descriptive naming over abbreviations
- singular dimension naming
- fact tables prefixed with fact_
- dimension tables prefixed with dim_

---

## Validation Rules

- Row counts validated after transformations
- Duplicate checks required for all dimensions
- Null handling documented explicitly
- KPI outputs reconciled before downstream usage
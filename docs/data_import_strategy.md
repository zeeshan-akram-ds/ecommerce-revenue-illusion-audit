# Data Import Strategy

## Raw Layer Philosophy

The raw layer preserves source-system transactional fidelity.

No analytical transformations, KPI calculations, filtering, or engineered fields are applied during import.

The raw dataset acts as the immutable source reference for all downstream validation and reconciliation.

---

## Import Workflow

CSV -> Python validation -> PostgreSQL raw schema

Python is used during import to:
- inspect column types
- validate encoding
- verify row counts
- handle timestamp parsing
- reduce import instability

SQL transformations occur only after raw-layer validation completes.

---

## Typing Strategy

Raw-layer data types prioritize:
- import stability
- source preservation
- safe parsing
- reconciliation reliability

Aggressive optimization and analytical transformations are deferred to downstream modeling layers.

---

## Validation Requirements

Before downstream modeling begins:
- row counts must reconcile with source CSV
- primary transactional grain must remain preserved
- timestamp parsing must validate successfully
- duplicate transaction checks must complete
- import failures must be logged before continuation
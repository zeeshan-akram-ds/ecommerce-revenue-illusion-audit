# Validation Checklist

## Raw Import Validation

- Source CSV row count matches PostgreSQL import
- Transactional grain preserved at order-line level
- No unexpected duplicate order item IDs
- Timestamp fields parsed successfully
- Critical profitability fields imported correctly
- Null rates reviewed against source data
- Monetary columns validated for numeric consistency

---

## Modeling Validation

- Dimension table uniqueness verified
- Fact table row counts reconcile correctly
- Join integrity validated across dimensions
- KPI outputs reconcile against raw calculations

---

## Reconciliation Standards

- Python outputs must reconcile against SQL within ±0.5%
- Power BI outputs must reconcile exactly against validated analytical outputs
- Any discrepancy blocks downstream progression until resolved
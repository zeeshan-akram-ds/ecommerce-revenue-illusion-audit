# Assumptions

## Product Cost Estimation
No direct unit cost field exists in the dataset.
Cost-related calculations use profit ratio and sales relationships as analytical estimates, not accounting-grade cost measurements.

---

## Delivery Risk Interpretation
`late_delivery_risk` is treated as an operational risk signal only.
It does not represent confirmed defects, returns, or customer dissatisfaction outcomes.

---

## Profitability Interpretation
Observed relationships between discounting, delivery risk, and profitability are treated as correlations within transactional behaviour.
The project does not claim causal relationships because no elasticity or experimental data exists.

---

## Statistical Thresholds
Products with fewer than 100 total orders are excluded from late delivery risk concentration rankings.
This threshold is documented in DL-010 and applied consistently across all operational KPI outputs.

---

## Revenue Recognition
PENDING_PAYMENT orders are treated as booked revenue and included in all downstream analysis.
This decision is documented in DL-009. If a material proportion of pending orders fail to convert, reported revenue and profit figures will be directionally overstated.
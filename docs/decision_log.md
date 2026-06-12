
# Decision Log

---

### DL-001 - Project Narrative Positioning
**Date:** 2026-05-18  
**Phase:** Foundation Planning  

**Decision:**  
Position the project around revenue illusion and operational profitability distortion rather than generic e-commerce analytics.

**Alternatives Considered:**  
- General profitability dashboard
- Inventory-only analysis
- Discount-focused margin audit

**Rationale:**  
The selected framing creates a stronger founder-facing narrative and better connects profitability, inventory, and operational risk into a single analytical story.

**Risk / Tradeoff:**  
The scope becomes broader and requires stronger analytical discipline to maintain coherence.

**Impact on Analysis:**  
All findings and deliverables must support the central narrative that revenue rankings can misrepresent true business health.

---

### DL-002 - Dataset Replacement Decision
**Date:** 2026-05-19  
**Phase:** Dataset Evaluation  

**Decision:**  
Reject the initial supply chain dataset and replace it with the DataCo Supply Chain dataset.

**Alternatives Considered:**  
- Continue with the original 101-row dataset
- Search for external inventory-focused datasets

**Rationale:**  
The original dataset lacked sufficient scale and operational depth to support statistical validation, forecasting, profitability segmentation, or meaningful operational analysis.

The DataCo dataset provides transactional granularity, multi-year temporal coverage, profitability metrics, and delivery performance fields aligned with the project's business narrative.

**Risk / Tradeoff:**  
The new dataset lacks direct inventory and supplier fields, requiring proxy-based engineering for inventory exposure and operational risk modeling.

**Impact on Analysis:**  
The project shifts toward operational profitability distortion, discount dependency, and fulfillment inefficiency while treating inventory analysis as modeled estimation rather than direct measurement.

---

### DL-003 - Project Analytical Positioning
**Date:** 2026-05-20  
**Phase:** Business Problem Definition  

**Decision:**  
Position the project as an operational profitability audit rather than a discount-focused or inventory-focused analysis.

**Alternatives Considered:**  
- Discount profitability audit
- Inventory optimization analysis
- Generic e-commerce KPI dashboard

**Rationale:**  
The selected positioning better aligns with the dataset's strengths in profitability, fulfillment performance, delivery risk, and transactional behavior.

It also creates a stronger and more differentiated founder-facing narrative around operational inefficiency hidden beneath revenue growth.

**Risk / Tradeoff:**  
The project requires tighter narrative discipline to avoid becoming overly broad across operational and profitability themes.

**Impact on Analysis:**  
All future analysis must prioritize operational profitability distortion and fulfillment inefficiency rather than isolated discount or inventory metrics.

---

### DL-004 - KPI Architecture Strategy
**Date:** 2026-05-20  
**Phase:** KPI Framework Design  

**Decision:**  
Structure project KPIs around profitability distortion, operational inefficiency, and revenue-to-profit divergence rather than traditional e-commerce reporting metrics.

**Alternatives Considered:**  
- Traditional revenue dashboard KPIs
- Sales-growth-first reporting
- Customer-centric KPI structure

**Rationale:**  
The selected KPI framework better supports the project's central narrative that revenue concentration can conceal operational and profitability weakness.

The KPI structure prioritizes diagnostic and risk-oriented measures rather than descriptive commercial reporting.

**Risk / Tradeoff:**  
Some KPIs require threshold calibration and careful interpretation to avoid overstating operational risk.

**Impact on Analysis:**  
Future SQL models, notebooks, dashboards, and executive reporting must align with the operational profitability audit framework defined here.

---

### DL-005 - Analytical Ownership & Reconciliation Strategy
**Date:** 2026-05-20   
**Phase:** Technical Architecture Planning  

**Decision:**  
Establish SQL as the exclusive ground truth layer, Python as the engineered analytics layer, and Power BI as the presentation layer.

**Alternatives Considered:**  
- Mixed KPI ownership across tools
- Power BI-centric calculation logic
- Python-first aggregation workflow

**Rationale:**  
The selected architecture maximizes analytical traceability, reconciliation reliability, and metric consistency across the project lifecycle.

Separating transactional truth from engineered estimation reduces ambiguity and prevents downstream reporting inconsistencies.

**Risk / Tradeoff:**  
The workflow requires stricter reconciliation discipline and additional validation effort before each project phase transition.

**Impact on Analysis:**  
All downstream notebooks, dashboards, and executive reporting must reconcile against validated SQL outputs before findings are treated as reliable.

---

### DL-006 - Data Modeling Strategy
**Date:** 2026-05-20   
**Phase:** Technical Architecture Planning  

**Decision:**  
Adopt a constrained four-table star schema centered around transactional order-line granularity.

**Selected Tables:**  
- fact_orders
- dim_product
- dim_region
- dim_date

**Alternatives Considered:**  
- Single flat transactional table
- Fully normalized warehouse-style schema

**Rationale:**  
The selected approach balances analytical professionalism, maintainability, and Power BI compatibility while avoiding unnecessary warehouse complexity.

The schema is intentionally constrained to support the project's KPI framework and operational profitability narrative without overengineering.

**Risk / Tradeoff:**  
Some reusable categorical structures remain inside the fact table to preserve simplicity and reduce unnecessary ETL overhead.

**Impact on Analysis:**  
Future SQL modeling and dashboard logic must preserve transactional fidelity while supporting SKU-level profitability and operational risk analysis.

---

### DL-007 - Retention of Extreme Negative Profit Ratio Records
**Date:** 2026-05-24
**Phase:** Raw Layer Quality Audit

**Decision:**
Retain all 6,301 records with profit ratios between −2.75 and −1.05 in all downstream analysis.

**Rationale:**
These records represent genuine cases of severe operational loss where costs exceeded revenue by up to 275%. Excluding them would artificially inflate profitability metrics and undermine the project's core audit of profit traps.

**Impact on Analysis:**
All downstream profitability aggregations include these records. Any summary statistics referencing average profit ratio must be interpreted with awareness of this tail distribution.

---

### DL-008 - Order Status Exclusion Boundaries
**Date:** 2026-05-24
**Phase:** Raw Layer Quality Audit

**Decision:**
Exclude SUSPECTED_FRAUD and CANCELED orders from all downstream profitability and operational KPI calculations.

**Rationale:**
These statuses represent either invalid transactions or incomplete operational lifecycles. Including them would distort revenue totals, profit aggregations, and delivery performance metrics.

**Impact on Analysis:**
All analytics schema builds and KPI queries apply a hard filter: `WHERE order_status NOT IN ('SUSPECTED_FRAUD', 'CANCELED')`. Row counts in all analytical outputs will reflect this exclusion explicitly.

---

### DL-009 - PENDING_PAYMENT Revenue Treatment
**Date:** 2026-05-24
**Phase:** Raw Layer Quality Audit

**Decision:**
Treat PENDING_PAYMENT orders as booked revenue and include them in downstream analysis.

**Rationale:**
The audit evaluates operational and profitability performance against the full commercial picture, not realized cash alone. Excluding pending orders would understate scale and distort fulfillment metrics for orders that are operationally active.

**Risk:**
If a material proportion of pending orders never convert, profit and revenue figures will be overstated. This is noted as a directional limitation in the final report.

---

### DL-010 - Low-Volume Product Exclusion from Delivery Risk Analysis
**Date:** 2026-05-24
**Phase:** Raw Layer Quality Audit

**Decision:**
Exclude the 46 products with fewer than 100 total orders from late delivery risk concentration analysis.

**Rationale:**
Fewer than 100 orders over three years produces statistically unreliable late delivery risk percentages. A single delayed shipment could generate a 10–20% risk rate for a low-volume product, producing misleading findings.

**Impact on Analysis:**
Late delivery risk rankings and concentration findings apply only to products with 100 or more orders. Low-volume products remain in profitability analysis where order count does not affect metric reliability in the same way.

---

---

### DL-011 - SKU Quadrant Classification Thresholds and Axis Definition
**Date:** 2026-06-09
**Phase:** Analytical Modeling

**Decision:**
Use catalog medians of `net_profit_pct` and `late_delivery_risk_rate` as the two classification axes. Revenue scale is represented as bubble size on the scatter plot rather than as a dedicated axis.

**Alternatives Considered:**
- Mean averages: rejected due to extreme right-skew distorting the central tendency
- Absolute fixed thresholds (e.g., 10% margin floor, 50% delivery risk ceiling): rejected as arbitrary external standards not grounded in this catalog's actual performance distribution
- Revenue vs. profit margin as axes: rejected because it cannot surface operational delivery failure as a classification dimension

**Quadrant Definitions:**
| Quadrant | Margin | Delivery Risk |
|---|---|---|
| Cash Generators | Above median | Below median |
| Operational Risks | Above median | Above median |
| Underperformers | Below median | Below median |
| Cut Candidates | Below median | Above median |

Revenue Traps are not a standalone quadrant. They are identified through rank divergence analysis (Notebook 01) and surfaced visually in this model via bubble size, large bubbles in the Cut Candidates quadrant represent the convergence of high revenue scale and poor operational health.

**Rationale:**
Medians isolate the true middle of the catalog's performance, preventing extreme high-volume outliers from shifting classification boundaries. Separating revenue scale from the axes keeps the model analytically clean while still communicating scale through the bubble dimension.

**Impact on Analysis:**
All quadrant assignments evaluate margin efficiency and operational delivery health simultaneously. Revenue scale remains visible but does not distort classification logic.

---

### DL-012 - Composite Risk Scoring Methodology
**Date:** 2026-06-12
**Phase:** Analytical Modeling

**Decision:**
Build composite risk score using three equally-weighted normalized vectors: late delivery risk rate, discount dependency rate, and rank divergence (inverted).

**Normalization Approach:**
MinMaxScaler applied independently to each vector. Rank divergence is inverted so that negative divergence (Revenue Traps) scores highest risk. Low-volume nulls in delivery risk are imputed with the catalog median prior to scaling to prevent distortion.

**Alternatives Considered:**
- Weighted scoring with higher emphasis on margin, rejected because it would over-penalize margin failures and under-penalize operational failures
- Raw values without normalization, rejected because the three metrics operate on incompatible scales

**Rationale:**
Equal weighting treats delivery failure, promotional dependency, and revenue-profit misalignment as equally damaging business risks. This reflects the project's multi-dimensional audit philosophy rather than a single-metric ranking.

**Impact on Analysis:**
The composite score is the primary output used for the executive priority list. Products in the top 10 are the first action targets regardless of their quadrant classification.
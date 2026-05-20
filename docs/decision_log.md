
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
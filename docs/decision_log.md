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

### DL-003 — Project Analytical Positioning
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
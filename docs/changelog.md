# Changelog

## 2026-05-19
- Initialized repository structure and documentation framework
- Defined project narrative, scope boundaries, and methodology standards
- Established Git workflow and branching strategy
- Began dataset acquisition and structural review planning

## 2026-05-20
- Replaced initial dataset after analytical suitability review
- Selected transactional DataCo supply chain dataset as primary analytical source
- Documented operational and inventory modeling constraints
- Defined formal business problem statement and core analytical questions
- Established evidence classification standards for future findings

## 2025-05-20
- Designed formal KPI framework aligned with operational profitability audit narrative
- Defined executive, operational, and risk-oriented KPI hierarchy
- Established revenue-to-profit divergence as the primary narrative KPI

## 2025-05-20
- Finalized analytical ownership model across SQL, Python, and Power BI
- Established SQL as the authoritative ground truth layer
- Defined formal reconciliation checkpoints before downstream analysis phases

## 2025-05-20
- Finalized constrained star schema modeling strategy
- Defined four-table analytical warehouse structure
- Established transactional fidelity standards for fact_orders

## 2025-05-21
- Began PostgreSQL analytical architecture setup
- Defined raw and analytics schema strategy
- Established SQL folder organization and SQL governance standards

## 2025-05-21
- Defined raw-layer import philosophy and validation standards
- Documented PostgreSQL import and typing strategy
- Created initial SQL schema setup script

## 2026-05-24
- Completed raw layer ingestion, 180,519 rows loaded into raw.dataco_orders
- Reconciliation confirmed: CSV source and PostgreSQL row counts match exactly
- Resolved column mapping mismatches between DataCo CSV headers and DDL definitions

## 2026-05-24
- Completed raw layer quality audit across structural integrity and analytical readiness
- Confirmed transactional uniqueness, zero null rates on critical fields, and 1,126-day temporal coverage
- Documented four analytical decisions in Decision Log (DL-007 through DL-010)

## 2026-05-26
- Built and validated all three analytics dimension tables
- dim_product: 118 unique SKUs, clean 1:1 product_card_id integrity confirmed
- dim_region: 167 unique geographic routing combinations verified
- dim_date: 1,127 continuous transaction dates confirmed, zero blackout periods
# Methodology Notes

## Analytical Philosophy
This project is structured as an operational and profitability audit rather than a traditional dashboard project.

The analysis prioritizes:
- Financial consequence over descriptive metrics
- Founder decisions over technical outputs
- Operational realism over isolated KPIs
- Validation and reconciliation across SQL, Python, and Power BI

## Core Narrative
"Your revenue ranking is lying to you."

The project investigates how high-revenue SKUs can create the illusion of business health while operational drag and inventory inefficiency silently damage profitability and cash flow.

## Consistency Standard
SQL establishes ground truth metrics.

Python must reproduce key metrics within a ±0.5% tolerance before downstream analysis begins.

Power BI must match validated Python outputs before dashboard development proceeds.

## Dataset Selection Rationale

The initial dataset considered for this project was rejected because it contained only 101 rows and could not credibly support statistical validation, forecasting, operational risk analysis, or profitability segmentation.

The selected DataCo Supply Chain dataset provides:
- Order-line transactional granularity
- Multi-year time coverage
- Operational delivery metrics
- Discount and profitability fields
- Sufficient scale for statistical analysis and scenario modeling

This better supports the project's central narrative around revenue illusion and operational profitability distortion.

## Evidence Standard

Findings are categorized using two levels of analytical confidence:

### Direct Evidence
Supported directly by raw transactional fields existing in the dataset.

### Directional Observation
Patterns that appear analytically meaningful but require caution due to data limitations or lack of causal evidence.

This distinction is maintained throughout the project to avoid overstating analytical certainty.

## Operational Risk Interpretation Standard

Operational risk findings are not triggered by single metrics in isolation.

A product or category is treated as a meaningful operational risk only when multiple weak operational and profitability signals converge consistently at meaningful transaction volume.

Single indicators are treated as warning flags rather than standalone conclusions.

## Analytical Ownership Model

### SQL Ownership - Ground Truth Layer
SQL is the authoritative source for all raw transactional KPI calculations.

This includes:
- Revenue metrics
- Profitability metrics
- Discount metrics
- Order volume metrics
- Delivery and fulfillment metrics
- Base aggregation logic

All downstream analysis must reconcile against SQL outputs before progressing.

---

### Python Ownership - Engineered Analytics Layer
Python is responsible for:
- SQL validation and reconciliation
- Engineered metrics
- Statistical analysis
- Risk scoring
- Scenario simulation

---

### Power BI Ownership - Presentation Layer
Power BI does not independently own analytical calculations.

It consumes validated SQL/Python outputs for:
- Executive reporting
- KPI presentation
- Visual storytelling
- Decision-oriented dashboarding

DAX calculations are limited to presentation-layer formatting and display logic.

---

## Reconciliation Standard

Before Phase 2 begins:
Python must reproduce SQL ground truth metrics within a ±0.5% tolerance threshold.

Before Phase 3 begins:
Power BI outputs must match validated Python outputs exactly.

Any unresolved discrepancy is treated as a project blocker and logged before downstream analysis proceeds.

## SQL Ground Truth Benchmarks
*Validated 2026-05-26. Python must reproduce all five within ±0.5% before analysis begins.*

| Metric | SQL Value |
|---|---|
| Total unique products | 118 |
| Total revenue | $35,214,428.98 |
| Average profit ratio | 0.1208 |
| Products with at least one loss-making order | 118 of 118 |
| Average late delivery risk rate | 0.5729 |

Financial reconciliation confirmed within tolerance (sales difference: $0.67, profit difference: $0.004).
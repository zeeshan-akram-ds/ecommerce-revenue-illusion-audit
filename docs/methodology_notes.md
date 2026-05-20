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

Findings are categorized using three levels of analytical confidence:

### Direct Evidence
Supported directly by raw transactional fields existing in the dataset.

### Engineered Estimate
Derived using documented assumptions or proxy calculations.

### Directional Observation
Patterns that appear analytically meaningful but require caution due to data limitations or lack of causal evidence.

This distinction is maintained throughout the project to avoid overstating analytical certainty.

## Operational Risk Interpretation Standard

Operational risk findings are not triggered by single metrics in isolation.

A product or category is treated as a meaningful operational risk only when multiple weak operational and profitability signals converge consistently at meaningful transaction volume.

Single indicators are treated as warning flags rather than standalone conclusions.
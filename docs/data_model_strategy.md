# Data Modeling Strategy

## Selected Modeling Approach

The project uses a constrained star schema designed specifically for operational profitability analysis.

The schema prioritizes:
- Transactional fidelity
- Analytical clarity
- Power BI compatibility
- Controlled complexity

The objective is to support the audit framework without introducing unnecessary warehouse engineering.

---

## Schema Structure

### fact_orders
Central transactional fact table at order-line granularity.

Contains:
- Revenue fields
- Profitability fields
- Discount fields
- Shipping metrics
- Delivery metrics
- Customer segment fields
- Transaction-level operational behavior

This table preserves raw transactional fidelity and acts as the primary analytical source layer.

---

### dim_product
Contains:
- Product identity
- Product category
- Department classification

Purpose:
Support SKU-level profitability and operational risk analysis.

---

### dim_region
Contains:
- Market segmentation
- Order geography
- Customer geography
- Regional classification fields

Purpose:
Support regional operational and profitability analysis.

---

### dim_date
Standardized date dimension supporting:
- Daily aggregation
- Monthly analysis
- Quarterly trends
- Time-series analysis
- Forecast preparation

---

## Modeling Constraints

The schema intentionally avoids excessive normalization.

Dimension tables are only created where:
- reusable analytical structure exists
- aggregation benefits are meaningful
- business interpretation improves

Fields such as shipping mode, customer segment, and delivery status remain inside fact_orders because they function as transactional operational attributes rather than standalone business entities.

---

## Architectural Principles

- fact_orders remains the immutable transactional source layer
- KPI calculations are not stored inside source tables
- Engineered metrics are handled downstream in Python
- Schema design must serve analytical clarity rather than architectural complexity
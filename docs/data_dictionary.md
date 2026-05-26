# Data Dictionary

## Dataset Overview

Primary dataset: `DataCoSupplyChainDataset.csv`

Granularity:
- One row represents one order-line transaction.

Time Coverage:
- 2015-01-01 to 2018-01-31

Total Records:
- 180,519 rows

Total Columns:
- 53 columns


---

# Core Analytical Fields

| Field Name | Description | Analytical Role |
|---|---|---|
| order_item_id | Unique order-line identifier | Transaction-level granularity |
| order_id | Order identifier | Multi-line order grouping |
| product_name | Product sold | SKU-level analysis |
| category_name | Product category | Category profitability analysis |
| sales | Revenue generated per order line | Revenue KPIs |
| order_item_total | Net revenue after discount | Net sales analysis |
| order_profit_per_order | Profit contribution per order | Core profitability KPI |
| order_item_profit_ratio | Profit margin ratio per transaction | Margin efficiency analysis |
| order_item_discount_rate | Discount percentage applied | Discount dependency analysis |
| order_item_quantity | Quantity sold | Sales velocity analysis |
| delivery_status | Delivery outcome classification | Operational performance analysis |
| late_delivery_risk | Binary late-risk flag | Operational risk analysis |
| shipping_mode | Fulfillment method used | Shipping efficiency analysis |
| days_for_shipping_real | Actual shipping duration | Operational delay analysis |
| days_for_shipment_scheduled | Planned shipping duration | Delay-gap calculation |
| market | High-level delivery market | Regional performance analysis |
| order_region | Geographic delivery region | Regional operational analysis |
| order_status | Final order state | Order lifecycle filtering |
| customer_segment | Customer classification | Segment-level profitability analysis |


---

# Important Dataset Constraints

- No true inventory fields exist in the raw dataset.
- No supplier, warehouse, or procurement data exists.
- No product cost field exists directly.
- Late delivery risk is treated as an operational signal, not a confirmed defect or return outcome.
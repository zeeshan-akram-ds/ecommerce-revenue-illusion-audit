-- Purpose: Consolidate validated raw transactions into an operational profitability fact table, link to surrogate 
-- dimensions, calculate shipping delays, and apply hard exclusions for cancelled and suspected fraud orders.

-- Assumption: 
-- PENDING_PAYMENT orders represent valid operational load and booked revenue (per DL-009). If that is wrong, 
-- the answer changes because including them overstates both realized cash and operational scale.

CREATE TABLE analytics.fact_orders (
    -- Surrogate & Foreign Keys
    order_item_id           INTEGER PRIMARY KEY,
    product_card_id         INTEGER NOT NULL,
    region_id               INTEGER NOT NULL,
    date_id                 DATE NOT NULL,

    -- Revenue & Profitability (preserving precision)
    sales                   NUMERIC(12,2),
    order_item_total        NUMERIC(12,2),
    benefit_per_order       NUMERIC(12,2),
    order_profit_per_order  NUMERIC(12,2),
    order_item_discount     NUMERIC(12,2),
    order_item_profit_ratio NUMERIC(6,4),
    order_item_discount_rate NUMERIC(6,4),

    -- Operational Metrics
    order_item_quantity          SMALLINT,
    days_for_shipping_real       SMALLINT,
    days_for_shipment_scheduled  SMALLINT,
    shipping_delay_days          INTEGER,           -- Engineered column
    late_delivery_risk           SMALLINT,
    delivery_status              TEXT,
    shipping_mode                TEXT,
    order_status                 TEXT
);

INSERT INTO analytics.fact_orders (
    order_item_id,
    product_card_id,
    region_id,
    date_id,
    sales,
    order_item_total,
    benefit_per_order,
    order_profit_per_order,
    order_item_discount,
    order_item_profit_ratio,
    order_item_discount_rate,
    order_item_quantity,
    days_for_shipping_real,
    days_for_shipment_scheduled,
    shipping_delay_days,
    late_delivery_risk,
    delivery_status,
    shipping_mode,
    order_status
)
SELECT 
    o.order_item_id,
    p.product_card_id,
    r.region_id,
    d.date_id,
    o.sales,
    o.order_item_total,
    o.benefit_per_order,
    o.order_profit_per_order,
    o.order_item_discount,
    o.order_item_profit_ratio,
    o.order_item_discount_rate,
    o.order_item_quantity,
    o.days_for_shipping_real,
    o.days_for_shipment_scheduled,
    (o.days_for_shipping_real - o.days_for_shipment_scheduled) AS shipping_delay_days,
    o.late_delivery_risk,
    o.delivery_status,
    o.shipping_mode,
    o.order_status
FROM raw.dataco_orders o
JOIN analytics.dim_product p 
    ON p.product_card_id = o.product_card_id
JOIN analytics.dim_region r 
    ON r.order_region = o.order_region 
   AND r.order_country = o.order_country 
   AND r.market = o.market
JOIN analytics.dim_date d 
    ON d.date_id = CAST(o.order_date AS DATE)
WHERE o.order_status NOT IN ('CANCELED', 'SUSPECTED_FRAUD')
  AND o.order_date IS NOT NULL;


-- Purpose: Quantify operational failure concentrations across products, shipping modes, 
-- and regions, isolating late delivery risk and margin volatility.

-- Assumption:
-- Assuming a static 1,126-day divisor for the sales velocity calculation (derived from the dim_date temporal span),
-- if that is wrong, the answer changes because applying product-specific active days would artificially inflate
-- the velocity of newly introduced or discontinued SKUs.

-- 1. Product-Level Operational KPIs & Sales Velocity
WITH product_ops AS (
    SELECT 
        p.product_card_id,
        p.product_name,
        COUNT(f.order_item_id) AS total_orders,
        SUM(f.order_item_quantity) AS total_units,
        AVG(f.late_delivery_risk) AS late_delivery_risk_rate,
        AVG(f.shipping_delay_days) AS avg_shipping_delay_days,
        STDDEV(f.order_item_profit_ratio) AS profit_ratio_volatility
    FROM analytics.fact_orders f
    JOIN analytics.dim_product p ON f.product_card_id = p.product_card_id
    GROUP BY 
        p.product_card_id, 
        p.product_name
)
SELECT 
    product_card_id,
    product_name,
    total_orders,
    ROUND((total_units / 1126.0)::NUMERIC, 2) AS units_sold_per_day,
    ROUND(late_delivery_risk_rate::NUMERIC, 4) AS late_delivery_risk_rate,
    ROUND(avg_shipping_delay_days::NUMERIC, 2) AS avg_shipping_delay_days,
    ROUND(profit_ratio_volatility::NUMERIC, 4) AS profit_ratio_volatility,
    CASE 
        WHEN total_orders >= 100 THEN RANK() OVER (PARTITION BY CASE WHEN total_orders >= 100 THEN 1 ELSE 0 END ORDER BY late_delivery_risk_rate DESC)
        ELSE NULL
    END AS delivery_risk_rank
FROM product_ops
ORDER BY delivery_risk_rank ASC NULLS LAST;


-- 2. Delivery Performance by Shipping Mode
SELECT 
    shipping_mode,
    COUNT(order_item_id) AS total_orders,
    ROUND(AVG(late_delivery_risk)::NUMERIC, 4) AS late_delivery_risk_rate,
    ROUND(AVG(shipping_delay_days)::NUMERIC, 2) AS avg_shipping_delay_days
FROM analytics.fact_orders
GROUP BY shipping_mode
ORDER BY late_delivery_risk_rate DESC;


-- 3. Delivery Performance by Region
SELECT 
    r.order_region,
    COUNT(f.order_item_id) AS total_orders,
    ROUND(AVG(f.late_delivery_risk)::NUMERIC, 4) AS late_delivery_risk_rate,
    ROUND(AVG(f.shipping_delay_days)::NUMERIC, 2) AS avg_shipping_delay_days
FROM analytics.fact_orders f
JOIN analytics.dim_region r ON f.region_id = r.region_id
GROUP BY r.order_region
ORDER BY late_delivery_risk_rate DESC;

-- Insights:
-- Customers paying for premium "First Class" shipping receive their orders late 100% of the time, 
-- averaging a full 1-day delay beyond the scheduled date. Ironically, "Standard Class" shipping—the 
-- cheapest option—is the most reliable, arriving slightly ahead of schedule on average (-0.01 days) 
-- with only a 39.7% risk rate. This suggests the business's supply chain is fundamentally incapable 
-- of supporting expedited SLAs, meaning every premium shipping order likely generates negative 
-- customer sentiment and potential refund liabilities.
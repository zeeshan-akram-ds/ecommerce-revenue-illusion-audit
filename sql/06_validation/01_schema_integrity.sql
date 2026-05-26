-- Purpose: Confirm the analytics star schema operates as a cohesive, referentially intact system without 
-- join fan-out, orphaned records, or metric drift before transitioning to the Python engineered layer.

-- Assumption
-- Assuming the expected fact table row count remains exactly 172,765, if that is wrong, the answer changes 
-- because any deviation during the full star join indicates an unintended cartesian product or fan-out in the dimension logic.

-- 1. Foreign Key Integrity Check (Orphan Detection)
SELECT 
    SUM(CASE WHEN p.product_card_id IS NULL THEN 1 ELSE 0 END) AS orphaned_products,
    SUM(CASE WHEN r.region_id IS NULL THEN 1 ELSE 0 END) AS orphaned_regions,
    SUM(CASE WHEN d.date_id IS NULL THEN 1 ELSE 0 END) AS orphaned_dates
FROM analytics.fact_orders f
LEFT JOIN analytics.dim_product p ON f.product_card_id = p.product_card_id
LEFT JOIN analytics.dim_region r ON f.region_id = r.region_id
LEFT JOIN analytics.dim_date d ON f.date_id = d.date_id;

-- 2. Join Completeness Check (Fan-out Detection)
SELECT 
    COUNT(*) AS full_join_row_count,
    CASE 
        WHEN COUNT(*) = 172765 THEN 'Pass: No Fan-out'
        ELSE 'Fail: Fan-out Detected!'
    END AS join_status
FROM analytics.fact_orders f
JOIN analytics.dim_product p ON f.product_card_id = p.product_card_id
JOIN analytics.dim_region r ON f.region_id = r.region_id
JOIN analytics.dim_date d ON f.date_id = d.date_id;

-- 3. Final Schema Row Counts Summary
SELECT 
	'fact_orders' AS table_name, 
	COUNT(*) AS total_rows FROM analytics.fact_orders
UNION ALL
SELECT 
	'dim_product', COUNT(*) FROM analytics.dim_product
UNION ALL
SELECT 
	'dim_region', COUNT(*) FROM analytics.dim_region
UNION ALL
SELECT 
	'dim_date', COUNT(*) FROM analytics.dim_date
ORDER BY total_rows DESC;

-- 4. Consolidated KPI Benchmark Output (Run against full schema)
SELECT 
    COUNT(DISTINCT p.product_card_id) AS total_unique_products,
    ROUND(SUM(f.sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(f.order_profit_per_order)::NUMERIC, 2) AS total_profit,
    ROUND(AVG(f.order_item_profit_ratio)::NUMERIC, 4) AS avg_net_profit_ratio,
    ROUND(AVG(f.late_delivery_risk)::NUMERIC, 4) AS avg_late_delivery_risk_rate
FROM analytics.fact_orders f
JOIN analytics.dim_product p ON f.product_card_id = p.product_card_id
JOIN analytics.dim_region r ON f.region_id = r.region_id
JOIN analytics.dim_date d ON f.date_id = d.date_id;

-- Insights
-- The strict exclusion of cancelled and suspected fraud orders isolated exactly 172,765 valid transactions 
-- representing genuine operational load. Downstream Python simulations will now evaluate true logistical 
-- risk without being skewed by administrative or fraudulent noise.
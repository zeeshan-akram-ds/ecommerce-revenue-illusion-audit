-- Query 1: Transactional Uniqueness Check
-- Purpose: Verify transactional uniqueness at the lowest grain by ensuring order_item_id contains no duplicates.

SELECT 
    order_item_id,
    COUNT(*) as duplicate_count
FROM 
    raw.dataco_orders
GROUP BY 
    order_item_id
HAVING 
    COUNT(*) > 1;

-- Interpretation:
-- Zero rows returned confirms the raw dataset preserves a strict 1:1 relationship at the order_item_id level. 
-- The transactional grain is intact. Downstream counts, revenue sums, and profitability aggregations can 
-- proceed without deduplication logic.


-- Query 2: Critical Field Completeness
-- Purpose: Quantify missing data (null rates) across core profitability and operational fields.


SELECT 
    ROUND((SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 4) AS sales_null_pct,
    ROUND((SUM(CASE WHEN order_item_discount IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 4) AS discount_null_pct,
    ROUND((SUM(CASE WHEN order_profit_per_order IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 4) AS profit_null_pct,
    ROUND((SUM(CASE WHEN shipping_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 4) AS shipping_date_null_pct,
    ROUND((SUM(CASE WHEN late_delivery_risk IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 4) AS late_delivery_null_pct
FROM 
    raw.dataco_orders;

-- Interpretation:
-- Zero missing values across critical financial and operational fields confirms the dataset is analytically viable. 
-- I do not need to build imputation logic or exclude records for core profitability and delivery KPI calculations.


-- Query 3: Financial Boundary Validation
-- Purpose: Detect impossible financial values, specifically negative sales or 
-- extreme profit ratios that indicate data corruption.

SELECT 
    SUM(CASE WHEN sales < 0 THEN 1 ELSE 0 END) AS bad_sales_count,
    SUM(CASE WHEN order_item_profit_ratio < -1 OR order_item_profit_ratio > 1 THEN 1 ELSE 0 END) AS profit_outlier_count,
    MIN(CASE WHEN order_item_profit_ratio < -1 OR order_item_profit_ratio > 1 THEN order_item_profit_ratio END) AS min_outlier_ratio,
    MAX(CASE WHEN order_item_profit_ratio < -1 OR order_item_profit_ratio > 1 THEN order_item_profit_ratio END) AS max_outlier_ratio
FROM 
    raw.dataco_orders;
-- Interpretation
-- The data shows 6,301 records—approximately 3.5% of the 180,519 total volume—possess profit ratios
-- between -2.75 and -1.05. This suggests these are not data entry errors or random corruption, 
-- but rather instances of severe negative margins where operational costs or discounts exceeded revenue by up to 275%. 
-- These records must remain in the dataset; excluding them would artificially inflate profitability 
-- and destroy the core analysis of profit traps.


-- Query 4: Categorical Consistency
-- Purpose: Audit delivery_status categorical consistency to identify data entry errors or unexpected variations.

SELECT
	delivery_status,
	COUNT(*) AS total_rows
FROM 
	raw.dataco_orders
GROUP BY
	delivery_status
ORDER BY
	total_rows DESC

-- Interpretation
-- The data shows "Late delivery" accounts for 98,977 orders, or 54.8% of the entire transaction volume. 
-- This suggests a systemic operational failure rather than isolated fulfillment errors, 
-- validating the project's focus on delivery inefficiency as a core business problem. 
-- The 7,754 "Shipping canceled" records represent incomplete operational lifecycles; 
-- I must determine whether to exclude these from downstream profitability calculations in the next analytical phase.



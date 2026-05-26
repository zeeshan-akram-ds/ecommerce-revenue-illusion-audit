-- Purpose: Reconcile fact table aggregations against raw ground truth and generate
-- the five executive benchmarks required for Python validation.

-- Assumption
-- Assuming a ±0.5% tolerance for float rounding variance during the raw-to-fact revenue and profit reconciliation, if that 
-- is wrong, the answer changes because strict absolute equality will fail due to PostgreSQL float-to-numeric casting nuances.

-- Row Count & Exclusions Validation
SELECT 
    (SELECT COUNT(*) FROM raw.dataco_orders) AS raw_total_rows,
    (SELECT COUNT(*) FROM analytics.fact_orders) AS fact_orders_rows,
    (SELECT COUNT(*) FROM raw.dataco_orders 
     WHERE order_status IN ('CANCELED', 'SUSPECTED_FRAUD')) AS excluded_rows,
    (SELECT COUNT(*) FROM analytics.fact_orders) 
     + (SELECT COUNT(*) FROM raw.dataco_orders 
        WHERE order_status IN ('CANCELED', 'SUSPECTED_FRAUD')) AS fact_plus_excluded,
    CASE 
        WHEN (SELECT COUNT(*) FROM analytics.fact_orders) 
           + (SELECT COUNT(*) FROM raw.dataco_orders 
              WHERE order_status IN ('CANCELED', 'SUSPECTED_FRAUD')) 
           = (SELECT COUNT(*) FROM raw.dataco_orders) 
        THEN 'Row Count Matches' 
        ELSE 'Row Count Mismatch!' 
    END AS validation_status;

-- Financial Reconciliation
WITH raw_summary AS (
    SELECT 
        SUM(sales) AS raw_sales,
        SUM(order_profit_per_order) AS raw_total_profit
    FROM raw.dataco_orders
    WHERE order_status NOT IN ('CANCELED', 'SUSPECTED_FRAUD')
)
SELECT 
    r.raw_sales,
    f.fact_sales,
    (r.raw_sales - f.fact_sales) AS sales_difference,
    r.raw_total_profit,
    f.fact_total_profit,
    (r.raw_total_profit - f.fact_total_profit) AS profit_difference,
    CASE 
        WHEN ABS(r.raw_sales - f.fact_sales) < 1.0 AND ABS(r.raw_total_profit - f.fact_total_profit) < 1.0
            THEN 'Financials Reconciled within Tolerance' 
        ELSE 'Reconciliation Failed!' 
    END AS reconciliation_status
FROM raw_summary r
CROSS JOIN (
    SELECT 
        SUM(sales) AS fact_sales,
        SUM(order_profit_per_order) AS fact_total_profit
    FROM analytics.fact_orders
) f;

-- The Five Benchmarks (For Python Validation)
SELECT 
    COUNT(DISTINCT p.product_card_id) AS total_unique_products,
    ROUND(SUM(f.sales)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(f.order_item_profit_ratio)::NUMERIC, 4) AS avg_net_profit_ratio,
    COUNT(DISTINCT CASE WHEN f.order_profit_per_order < 0 THEN p.product_card_id END) AS loss_making_products,
    ROUND(AVG(f.late_delivery_risk)::NUMERIC, 4) AS avg_late_delivery_risk_rate
FROM analytics.fact_orders f
JOIN analytics.dim_product p 
    ON p.product_card_id = f.product_card_id;

-- Insights:
-- The data shows a $0.67 variance on $35.2M in revenue, representing a divergence of 0.0000019%. 
-- This mathematically validates that the float-to-numeric type conversion successfully preserved financial 
-- fidelity without data loss.

-- The benchmark data shows 118 out of 118 products have generated negative profit orders. This suggests that 
-- loss-making transactions are a systemic operational failure across the entire catalog, not an isolated issue 
-- with a few bad SKUs. The entire product line is exposed to operational drag.
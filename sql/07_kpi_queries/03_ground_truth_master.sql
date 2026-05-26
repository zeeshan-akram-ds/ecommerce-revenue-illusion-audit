-- Purpose: Consolidate all SKU-level profitability and operational KPIs into 
-- a single ground truth dataset for Python statistical validation and quadrant modeling.

WITH profit_kpis AS (
    SELECT 
        p.product_card_id,
        p.product_name,
        p.category_name,
        ROUND(SUM(f.sales)::NUMERIC, 2) AS total_revenue,
        ROUND(SUM(f.order_profit_per_order)::NUMERIC, 2) AS total_profit,
        ROUND((SUM(f.order_profit_per_order) / NULLIF(SUM(f.sales), 0))::NUMERIC, 4) AS net_profit_pct,
        RANK() OVER (ORDER BY SUM(f.sales) DESC) AS revenue_rank,
        RANK() OVER (ORDER BY SUM(f.order_profit_per_order) DESC) AS profit_rank,
        (RANK() OVER (ORDER BY SUM(f.sales) DESC) - RANK() OVER (ORDER BY SUM(f.order_profit_per_order) DESC)) AS rank_divergence,
        ROUND((SUM(CASE WHEN f.order_profit_per_order < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*))::NUMERIC, 2) AS negative_profit_order_pct,
        ROUND((SUM(CASE WHEN f.order_item_discount_rate > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*))::NUMERIC, 2) AS discount_dependency_rate
    FROM analytics.fact_orders f
    JOIN analytics.dim_product p ON f.product_card_id = p.product_card_id
    GROUP BY p.product_card_id, p.product_name, p.category_name
),
ops_kpis AS (
    SELECT 
        f.product_card_id,
        COUNT(f.order_item_id) AS total_orders,
        ROUND((SUM(f.order_item_quantity) / 1126.0)::NUMERIC, 2) AS units_sold_per_day,
        ROUND(AVG(f.late_delivery_risk)::NUMERIC, 4) AS late_delivery_risk_rate,
        ROUND(AVG(f.shipping_delay_days)::NUMERIC, 2) AS avg_shipping_delay_days,
        ROUND(STDDEV(f.order_item_profit_ratio)::NUMERIC, 4) AS profit_ratio_volatility
    FROM analytics.fact_orders f
    GROUP BY f.product_card_id
)
SELECT 
    pk.product_card_id,
    pk.product_name,
    pk.category_name,
    pk.total_revenue,
    pk.total_profit,
    pk.net_profit_pct,
    pk.revenue_rank,
    pk.profit_rank,
    pk.rank_divergence,
    pk.negative_profit_order_pct,
    pk.discount_dependency_rate,
    ok.total_orders,
    ok.units_sold_per_day,
    ok.late_delivery_risk_rate,
    ok.avg_shipping_delay_days,
    ok.profit_ratio_volatility,
    CASE 
        WHEN ok.total_orders >= 100 THEN RANK() OVER (PARTITION BY CASE WHEN ok.total_orders >= 100 THEN 1 ELSE 0 END ORDER BY ok.late_delivery_risk_rate DESC)
        ELSE NULL
    END AS delivery_risk_rank
FROM profit_kpis pk
JOIN ops_kpis ok ON pk.product_card_id = ok.product_card_id
ORDER BY pk.revenue_rank ASC;
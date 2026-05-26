-- Purpose: Expose revenue-to-profit distortion by calculating profitability, discount dependency, 
-- and rank divergence at the product and category levels.

-- Assuming "discount dependency rate" is defined as the percentage of total transactions where a non-zero discount 
-- was applied, if that is wrong, the answer changes because calculating it as average discount depth instead of 
-- transaction frequency measures pricing strategy rather than promotional reliance.

-- 1. Product-Level Profitability KPIs
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
GROUP BY 
    p.product_card_id,
    p.product_name,
    p.category_name
ORDER BY total_revenue DESC;


-- 2. Category-Level Profitability KPIs
SELECT 
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
GROUP BY 
    p.category_name
ORDER BY total_revenue DESC;

-- Insights:
-- The data shows zero rank divergence among the top 4 revenue-generating products, they are genuinely
-- the most profitable items in absolute terms. However, it reveals a deeply fragile operational core:
-- ~94.4% of their transactions require discounts to convert, and ~18.5% of their orders result in a 
-- net financial loss. This suggests the business is buying its top-line revenue through severe 
-- promotional dependency and absorbing substantial fulfillment losses to maintain the appearance of scale.
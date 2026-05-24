-- Query 1: Temporal Coverage
-- Purpose: Confirm temporal coverage by identifying the earliest and latest 
-- order dates to ensure sufficient time-series depth for scenario modeling.

SELECT
    MIN(CAST(order_date AS TIMESTAMP)) AS min_order_date,
    MAX(CAST(order_date AS TIMESTAMP)) AS max_order_date,
    (MAX(CAST(order_date AS DATE)) - MIN(CAST(order_date AS DATE))) AS days_span
FROM
    raw.dataco_orders;

-- Interpretation
-- The data shows a 1,126-day temporal span, covering transactions from January 1, 2015, to January 31, 2018. 
-- This suggests the dataset possesses sufficient multi-year depth to support seasonal trend analysis, 
-- baseline forecasting, and reliable statistical validation of operational failure patterns.


-- Query 2: Order Status Distribution
-- Purpose: Quantify order statuses to define exclusion boundaries for cancelled, returned,
-- and suspected fraud records prior to profitability calculations.

SELECT
	order_status,
	COUNT(*) AS total_rows
FROM 
	raw.dataco_orders
GROUP BY
	order_status
ORDER BY
	total_rows DESC;

-- Assumption:
-- Assuming "PENDING_PAYMENT" orders represent unrealized cash, if that is wrong, 
-- the answer changes because excluding them would drastically understate the business's apparent commercial scale, 
-- requiring me to explicitly define whether the audit evaluates "booked revenue" or "realized revenue" in the Decision Log.

-- Interpretation
-- The data shows 4,062 "SUSPECTED_FRAUD" and 3,692 "CANCELED" orders. This suggests I must implement 
-- hard exclusion logic in the fact_orders build to prevent invalid transactions from distorting profitability KPIs.


-- Query 3: Discount Boundary Check
-- Purpose: Verify order_item_discount_rate behaves strictly as a valid ratio
-- between 0 and 1 to prevent downstream calculation errors.

SELECT
    MIN(order_item_discount_rate) AS min_dct_value,
    MAX(order_item_discount_rate) AS max_dct_value,
    ROUND(AVG(order_item_discount_rate)::numeric, 2) AS avg_dct_value,
    SUM(CASE WHEN order_item_discount_rate < 0 OR order_item_discount_rate > 1 THEN 1 ELSE 0 END) AS invalid_discount_count
FROM
    raw.dataco_orders;

-- Assumption:
-- Assuming order_item_discount_rate captures the total promotional depth applied to the transaction, 
-- if that is wrong, the answer changes because unrecorded cart-level coupons or off-invoice rebates 
-- would mean the true discount dependency is far worse than the observed 25% maximum.

-- Interpretation:
-- The data shows discount rates are strictly bounded between 0% and 25%, with a 10% average. The absence of values 
-- outside the 0 to 1 range confirms the field is structurally clean and ready for downstream margin simulations.


-- Query 4: Product Volume Viability
-- Purpose: Surface the distribution of order counts per product to flag items with statistically unreliable transaction volumes.

WITH products_summary AS (
    SELECT
        product_card_id,
        COUNT(*) AS total_orders
    FROM raw.dataco_orders
    GROUP BY product_card_id
)
SELECT
    CASE
        WHEN total_orders < 100   THEN '1. Low (< 100)'
        WHEN total_orders < 300   THEN '2. Medium (100 - 299)'
        WHEN total_orders < 10000 THEN '3. High (300 - 9,999)'
        ELSE                           '4. Extreme Outliers (10,000+)'
    END AS order_volume_category,
    COUNT(*) AS num_products,
    MIN(total_orders) AS min_orders,
    MAX(total_orders) AS max_orders,
    ROUND(AVG(total_orders), 0) AS avg_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM products_summary
GROUP BY 1
ORDER BY 1;

-- Assumption:
-- Assuming the 46 "Low (< 100)" products are excluded from late delivery risk analysis. 
-- Including them would produce statistically insignificant results due to very low 
-- sample sizes (<100 orders over 3 years), weakening the credibility of the findings.

-- Interpretation
-- The data reveals strong concentration: 9 products (7.6%) drive extreme volume with an average of 17,382 orders each, 
-- while 46 products (39%) generated fewer than 100 orders. This heavy reliance on a tiny fraction of the 
-- catalog highlights significant product performance imbalance.


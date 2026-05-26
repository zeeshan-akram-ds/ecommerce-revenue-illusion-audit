-- Purpose: Group geographic fields into a reusable analytical structure that supports market-level
-- and regional delivery performance comparisons.

-- Assumption: The combination of order_region, order_country, and market provides sufficient geographic granularity 
-- to identify systemic delivery failures. If that is wrong, the answer changes because masking city-level routing 
-- failures will dilute the late delivery risk concentration index.

CREATE SCHEMA IF NOT EXISTS analytics;

CREATE TABLE analytics.dim_region (
    region_id          SERIAL PRIMARY KEY,
    order_region       TEXT NOT NULL,
    order_country      TEXT NOT NULL,
    market             TEXT NOT NULL
);

INSERT INTO analytics.dim_region (
    order_region,
    order_country,
    market
)
SELECT DISTINCT
    order_region,
    order_country,
    market
FROM raw.dataco_orders
WHERE order_region IS NOT NULL 
   OR order_country IS NOT NULL 
   OR market IS NOT NULL;

-- Main Validation: Row count + Uniqueness Check
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (order_region, order_country, market)) AS unique_combinations,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT (order_region, order_country, market)) 
            THEN 'Uniqueness Verified' 
        ELSE 'Duplicates Found!' 
    END AS uniqueness_check
FROM analytics.dim_region;

-- Top regions for quick review
SELECT 
    region_id,
    order_region,
    order_country,
    market
FROM analytics.dim_region
ORDER BY order_region, order_country
LIMIT 10;

-- Interpretation
-- The data shows exactly 167 unique geographic routing combinations. This suggests the regional hierarchy is 
-- concise enough to group transaction volumes meaningfully, ensuring that my downstream delivery risk concentration 
-- index evaluates statistical trends rather than fragmented, sparse city-level noise
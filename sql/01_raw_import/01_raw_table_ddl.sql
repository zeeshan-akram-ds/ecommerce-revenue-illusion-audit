-- File        : 01_raw_table_ddl.sql
-- Schema      : raw
-- Table       : dataco_orders
-- Purpose     : Create the raw ingestion table for the DataCo Supply Chain
--               dataset.
--
-- Notes:
-- - This table preserves source-system transactional fidelity.
-- - No analytical transformations are applied in the raw layer.
-- - No KPI calculations, filtering, or engineered fields exist here.
-- - Downstream analytical tables are built separately in the analytics schema.


-- Create raw schema

CREATE SCHEMA IF NOT EXISTS raw;

-- Recreate raw table

DROP TABLE IF EXISTS raw.dataco_orders;

-- Raw transactional ingestion table
-- Column names are standardized to snake_case for SQL readability and
-- maintainability while preserving original business meaning.

CREATE TABLE raw.dataco_orders (

    -- Transaction & entity identifiers

    order_item_id                   INTEGER,
    order_id                        INTEGER,
    order_customer_id               INTEGER,
    customer_id                     INTEGER,
    product_card_id                 INTEGER,
    product_category_id             INTEGER,
    category_id                     INTEGER,
    department_id                   INTEGER,
    order_item_cardprod_id          INTEGER,

    -- Transactional timestamps
    -- Stored as TEXT in raw layer to maximize ingestion stability.

    order_date                      TEXT,
    shipping_date                   TEXT,

    -- Revenue & profitability metrics
    -- NUMERIC used to preserve exact arithmetic for reconciliation accuracy.

    sales                           NUMERIC(12,2),
    sales_per_customer              NUMERIC(12,2),
    order_item_total                NUMERIC(12,2),
    order_item_product_price        NUMERIC(12,2),
    product_price                   NUMERIC(12,2),
    benefit_per_order               NUMERIC(12,2),
    order_profit_per_order          NUMERIC(12,2),
    order_item_discount             NUMERIC(12,2),

    -- Ratio metrics
    -- FLOAT intentionally avoided to reduce reconciliation inconsistencies.

    order_item_profit_ratio         NUMERIC(6,4),
    order_item_discount_rate        NUMERIC(6,4),


    -- Quantity & operational metrics

    order_item_quantity             SMALLINT,
    days_for_shipping_real          SMALLINT,
    days_for_shipment_scheduled     SMALLINT,
    late_delivery_risk              SMALLINT,

    -- Product & category fields

    product_name                    TEXT,
    category_name                   TEXT,
    department_name                 TEXT,
    product_description             TEXT,
    product_image                   TEXT,
    product_status                  SMALLINT,

    -- Customer fields

    customer_fname                  TEXT,
    customer_lname                  TEXT,
    customer_email                  TEXT,
    customer_password               TEXT,
    customer_segment                TEXT,
    customer_city                   TEXT,
    customer_state                  TEXT,
    customer_country                TEXT,
    customer_street                 TEXT,
    customer_zipcode                TEXT,

    -- Order & delivery fields

    delivery_status                 TEXT,
    shipping_mode                   TEXT,
    order_status                    TEXT,
    order_city                      TEXT,
    order_state                     TEXT,
    order_country                   TEXT,
    order_region                    TEXT,
    order_zipcode                   TEXT,

    -- Market & regional fields

    market                          TEXT,

    -- Geographic coordinates

    latitude                        NUMERIC(10,6),
    longitude                       NUMERIC(10,6),


    -- Miscellaneous source fields
	
    type                            TEXT

);


-- End of file
-- Next step:
-- Validate source CSV structure and design raw ingestion workflow.
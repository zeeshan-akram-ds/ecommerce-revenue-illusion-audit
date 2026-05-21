-- Business Purpose:
-- Initialize PostgreSQL schema structure for the
-- operational profitability audit project.
--
-- Schemas:
-- raw        -> immutable imported source data
-- analytics  -> cleaned analytical star schema
--
-- Notes:
-- No tables are created in this script.

CREATE SCHEMA IF NOT EXISTS raw;

CREATE SCHEMA IF NOT EXISTS analytics;
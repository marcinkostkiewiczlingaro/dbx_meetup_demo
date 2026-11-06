-- Gold: conformed store dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_store; one row per store.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_store
  COMMENT 'Conformed store dimension for the store-sales star schema.'
AS
SELECT
  store_key,
  store_id,
  store_name,
  store_city,
  store_county,
  store_state,
  store_zip,
  store_country,
  store_market_id,
  store_company,
  floor_space,
  number_employees
FROM silver.dim_store;

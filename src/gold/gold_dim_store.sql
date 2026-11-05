-- Gold: conformed store dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_store; one row per store.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_store
  COMMENT 'Conformed store dimension for the store-sales star schema.'
AS
SELECT
  store_key,
  store_id,
  store_name,
  city,
  state,
  country,
  floor_space_sqft
FROM silver.dim_store;

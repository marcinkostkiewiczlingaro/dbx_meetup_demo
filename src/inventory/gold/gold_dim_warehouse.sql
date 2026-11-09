-- Gold: conformed warehouse dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_warehouse; one row per warehouse.
-- Business domain: Inventory (see docs/domains/README.md). The domain tag is carried in the
-- COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_warehouse
  COMMENT 'Conformed warehouse dimension for the inventory star schema. domain=Inventory'
AS
SELECT
  warehouse_key,
  warehouse_id,
  warehouse_name,
  warehouse_sq_ft,
  warehouse_city,
  warehouse_county,
  warehouse_state,
  warehouse_zip,
  warehouse_country,
  gmt_offset
FROM silver.dim_warehouse;

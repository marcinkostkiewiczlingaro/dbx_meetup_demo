-- Silver: cleansed warehouse dimension with business column names.
-- Business key: warehouse_key (the TPC-DS surrogate), one row per warehouse.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_warehouse (
  CONSTRAINT valid_warehouse_key EXPECT (warehouse_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed warehouses with business names. Source: bronze.warehouse.'
AS
SELECT
  w_warehouse_sk    AS warehouse_key,
  w_warehouse_id    AS warehouse_id,
  w_warehouse_name  AS warehouse_name,
  w_warehouse_sq_ft AS warehouse_sq_ft,
  w_city            AS warehouse_city,
  w_county          AS warehouse_county,
  w_state           AS warehouse_state,
  w_zip             AS warehouse_zip,
  w_country         AS warehouse_country,
  w_gmt_offset      AS gmt_offset
FROM bronze.warehouse;

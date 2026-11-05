-- Silver: cleansed franchise (store) dimension with business column names.
-- A franchise is the physical bakery location where sales happen.
-- Business key: franchise_key (one row per franchise). Links to its supplier.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_franchise (
  CONSTRAINT valid_franchise_key EXPECT (franchise_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed franchises (stores) with business names. Source: bronze.sales_franchises.'
AS
SELECT
  franchiseID   AS franchise_key,
  name          AS franchise_name,
  city          AS city,
  district      AS district,
  zipcode       AS zip_code,
  country       AS country,
  size          AS store_size,
  supplierID    AS supplier_key
FROM bronze.sales_franchises;

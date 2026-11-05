-- Silver: cleansed product (item) dimension with business column names.
-- Business key: product_key (one row per item version).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_item (
  CONSTRAINT valid_product_key EXPECT (product_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed products with business names. Source: bronze.item.'
AS
SELECT
  i_item_sk        AS product_key,
  i_item_id        AS product_id,
  i_product_name   AS product_name,
  i_brand          AS brand,
  i_category       AS category,
  i_class          AS product_class,
  i_current_price  AS list_price
FROM bronze.item;

-- Silver: cleansed item (product) dimension with business column names.
-- An item is a product sold in a store. Business key: item_key (one row per item).
-- TPC-DS item carries slowly-changing history; keep only the current record.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_item (
  CONSTRAINT valid_item_key EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed items (products), current records only. Source: bronze.item.'
AS
SELECT
  i_item_sk        AS item_key,
  i_item_id        AS item_id,
  i_product_name   AS item_name,
  i_item_desc      AS item_description,
  i_brand          AS brand,
  i_class          AS class,
  i_category       AS category,
  i_manufact       AS manufacturer,
  i_current_price  AS current_price,
  i_wholesale_cost AS wholesale_cost
FROM bronze.item
WHERE i_rec_end_date IS NULL;

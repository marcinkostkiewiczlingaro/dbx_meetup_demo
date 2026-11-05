-- Gold: conformed product dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_item; one row per product.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_item
  COMMENT 'Conformed product dimension for the store-sales star schema.'
AS
SELECT
  product_key,
  product_id,
  product_name,
  brand,
  category,
  product_class,
  list_price
FROM silver.dim_item;

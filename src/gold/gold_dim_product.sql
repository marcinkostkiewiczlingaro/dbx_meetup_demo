-- Gold: conformed product dimension, derived from the sales fact.
-- The bakehouse sample has no product table, so the product list comes from the
-- distinct products actually sold. product_name is the natural business key.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_product
  COMMENT 'Conformed product dimension, derived from silver.fct_sales.'
AS
SELECT DISTINCT
  product_name
FROM silver.fct_sales;

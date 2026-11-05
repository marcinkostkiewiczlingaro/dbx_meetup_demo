-- Gold: conformed sales fact for the star schema and the Metric View.
-- Grain: one row per sales transaction. Inner join to the customer and franchise
-- dimensions keeps only referentially clean rows. product_name and sold_date link to
-- the derived product and date dimensions.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_sales
  COMMENT 'Conformed sales fact. Grain: one transaction. Source: silver.fct_sales.'
AS
SELECT
  f.sales_transaction_id,
  f.customer_key,
  f.franchise_key,
  f.product_name,
  f.sold_date,
  f.payment_method,
  f.quantity,
  f.unit_price,
  f.sales_amount
FROM silver.fct_sales AS f
JOIN silver.dim_customer  AS c ON f.customer_key = c.customer_key
JOIN silver.dim_franchise AS r ON f.franchise_key = r.franchise_key;

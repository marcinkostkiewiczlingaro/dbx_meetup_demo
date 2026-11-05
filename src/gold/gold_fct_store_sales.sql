-- Gold: conformed store-sales fact for the star schema and the Metric View.
-- Grain: one row per sold line. Inner joins keep only rows with valid dimensions,
-- so the fact is referentially clean for analytics and Genie.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_store_sales
  COMMENT 'Conformed store-sales fact. Grain: one sold line. Source: silver.fct_store_sales.'
AS
SELECT
  f.sales_ticket_number,
  f.product_key,
  f.customer_key,
  f.store_key,
  f.date_key,
  f.quantity,
  f.unit_sales_price,
  f.gross_sales_amount,
  f.discount_amount,
  f.net_sales_amount,
  f.net_profit_amount
FROM silver.fct_store_sales AS f
JOIN silver.dim_item  AS i ON f.product_key = i.product_key
JOIN silver.dim_store AS s ON f.store_key = s.store_key
JOIN silver.dim_date  AS d ON f.date_key = d.date_key;

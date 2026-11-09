-- Gold: conformed store-sales fact for the star schema and the Metric View.
-- Grain: one store-sales line (ticket_number x item_key). Inner joins to customer, item,
-- and store keep only referentially clean rows. Promotion is optional, so it is left-joined.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_store_sales
  COMMENT 'Conformed store-sales fact. Grain: one ticket line. Source: silver.fct_store_sales. domain=Store Sales'
AS
SELECT
  f.ticket_number,
  f.item_key,
  f.customer_key,
  f.store_key,
  f.promo_key,
  f.date_key,
  f.sold_date,
  f.quantity,
  f.list_price,
  f.sales_price,
  f.wholesale_cost,
  f.sales_amount,
  f.discount_amount,
  f.net_paid,
  f.net_profit
FROM silver.fct_store_sales AS f
JOIN silver.dim_customer AS c ON f.customer_key = c.customer_key
JOIN silver.dim_item     AS i ON f.item_key     = i.item_key
JOIN silver.dim_store    AS s ON f.store_key     = s.store_key;

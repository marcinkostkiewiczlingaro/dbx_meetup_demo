-- Gold: conformed web-sales fact for the star schema and the Metric View.
-- Grain: one web-sales order line (order_number x item_key). Inner joins to the core
-- customer and item dims keep only referentially clean rows. Web site and web page are
-- optional, so they are left-joined.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_web_sales
  COMMENT 'Conformed web-sales fact. Grain: one order line. Source: silver.fct_web_sales. domain=Web Sales'
AS
SELECT
  f.order_number,
  f.item_key,
  f.customer_key,
  f.web_site_key,
  f.web_page_key,
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
FROM silver.fct_web_sales AS f
JOIN silver.dim_customer AS c ON f.customer_key = c.customer_key
JOIN silver.dim_item     AS i ON f.item_key     = i.item_key;

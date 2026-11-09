-- Gold presentation table: the store-sales fact widened with the descriptive dimension
-- columns the semantic layer needs. The Metric View and Genie read this one table, so
-- they need no joins. The star schema (fct_store_sales + dims) stays the modeling source;
-- this is the consumption table built from it.
-- Grain: one store-sales line (ticket_number x item_key).
CREATE OR REFRESH MATERIALIZED VIEW gold.store_sales_enriched
  COMMENT 'Wide store-sales table for the Metric View and Genie. Source: gold.fct_store_sales + dims. domain=Store Sales'
AS
SELECT
  f.ticket_number,
  f.date_key,
  f.sold_date,
  d.calendar_year,
  d.month_name,
  d.quarter_of_year,
  f.item_key,
  i.item_name,
  i.brand,
  i.class,
  i.category,
  i.manufacturer,
  f.customer_key,
  c.customer_state,
  c.customer_country,
  f.store_key,
  s.store_name,
  s.store_state,
  s.store_country,
  s.store_market_id,
  f.promo_key,
  p.promo_name,
  p.promo_purpose,
  f.quantity,
  f.list_price,
  f.sales_price,
  f.wholesale_cost,
  f.sales_amount,
  f.discount_amount,
  f.net_paid,
  f.net_profit
FROM gold.fct_store_sales AS f
JOIN gold.dim_item      AS i ON f.item_key     = i.item_key
JOIN gold.dim_customer  AS c ON f.customer_key = c.customer_key
JOIN gold.dim_store     AS s ON f.store_key     = s.store_key
JOIN gold.dim_date      AS d ON f.date_key      = d.date_key
LEFT JOIN gold.dim_promotion AS p ON f.promo_key = p.promo_key;

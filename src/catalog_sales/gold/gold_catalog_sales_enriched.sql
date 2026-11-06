-- Gold presentation table: the catalog-sales fact widened with the descriptive dimension
-- columns the semantic layer needs. The Metric View and Genie read this one table, so they
-- need no joins. It reads the conformed core dims (item, customer, date, promotion) owned
-- by the core pipeline and the catalog-only dims (call center, catalog page, ship mode).
-- Grain: one catalog-sales order line (order_number x item_key).
CREATE OR REFRESH MATERIALIZED VIEW gold.catalog_sales_enriched
  COMMENT 'Wide catalog-sales table for the Metric View and Genie. Source: gold.fct_catalog_sales + dims.'
AS
SELECT
  f.order_number,
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
  f.call_center_key,
  cc.call_center_name,
  cc.call_center_class,
  cc.call_center_state,
  cc.call_center_country,
  f.catalog_page_key,
  cp.catalog_department,
  cp.page_type,
  f.ship_mode_key,
  sm.ship_mode_type,
  sm.carrier,
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
FROM gold.fct_catalog_sales AS f
JOIN gold.dim_item         AS i  ON f.item_key         = i.item_key
JOIN gold.dim_customer     AS c  ON f.customer_key     = c.customer_key
JOIN gold.dim_date         AS d  ON f.date_key         = d.date_key
LEFT JOIN gold.dim_call_center  AS cc ON f.call_center_key  = cc.call_center_key
LEFT JOIN gold.dim_catalog_page AS cp ON f.catalog_page_key = cp.catalog_page_key
LEFT JOIN gold.dim_ship_mode    AS sm ON f.ship_mode_key    = sm.ship_mode_key
LEFT JOIN gold.dim_promotion    AS p  ON f.promo_key        = p.promo_key;

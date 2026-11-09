-- Gold: conformed catalog-returns fact for the star schema.
-- Grain: one catalog-return line (order_number x item_key). Inner joins to the core
-- customer and item dims keep only referentially clean rows.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_catalog_returns
  COMMENT 'Conformed catalog-returns fact. Grain: one return line. Source: silver.fct_catalog_returns. domain=Catalog Sales'
AS
SELECT
  f.order_number,
  f.item_key,
  f.customer_key,
  f.call_center_key,
  f.catalog_page_key,
  f.ship_mode_key,
  f.date_key,
  f.returned_date,
  f.return_quantity,
  f.return_amount,
  f.return_tax,
  f.return_fee,
  f.net_loss
FROM silver.fct_catalog_returns AS f
JOIN silver.dim_customer AS c ON f.customer_key = c.customer_key
JOIN silver.dim_item     AS i ON f.item_key     = i.item_key;

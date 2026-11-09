-- Gold: conformed store-returns fact for the star schema.
-- Grain: one store-return line (ticket_number x item_key). Inner joins to customer, item,
-- and store (the core dims and the store dim) keep only referentially clean rows.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_store_returns
  COMMENT 'Conformed store-returns fact. Grain: one return line. Source: silver.fct_store_returns. domain=Store Sales'
AS
SELECT
  f.ticket_number,
  f.item_key,
  f.customer_key,
  f.store_key,
  f.date_key,
  f.returned_date,
  f.return_quantity,
  f.return_amount,
  f.return_tax,
  f.return_fee,
  f.net_loss
FROM silver.fct_store_returns AS f
JOIN silver.dim_customer AS c ON f.customer_key = c.customer_key
JOIN silver.dim_item     AS i ON f.item_key     = i.item_key
JOIN silver.dim_store    AS s ON f.store_key     = s.store_key;

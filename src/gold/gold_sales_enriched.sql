-- Gold presentation table: the sales fact widened with the descriptive dimension
-- columns the semantic layer needs. The Metric View and Genie read this one table, so
-- they need no joins. The star schema (fct_sales + dims) stays the modeling source;
-- this is the consumption view built from it.
-- Grain: one row per sales transaction.
CREATE OR REFRESH MATERIALIZED VIEW gold.sales_enriched
  COMMENT 'Wide sales table for the Metric View and Genie. Source: gold.fct_sales + dims.'
AS
SELECT
  f.sales_transaction_id,
  f.sold_date,
  d.month_name,
  f.product_name,
  f.payment_method,
  f.franchise_key,
  r.franchise_name,
  r.country       AS franchise_country,
  f.customer_key,
  c.country       AS customer_country,
  f.quantity,
  f.unit_price,
  f.sales_amount
FROM gold.fct_sales AS f
JOIN gold.dim_franchise AS r ON f.franchise_key = r.franchise_key
JOIN gold.dim_customer  AS c ON f.customer_key = c.customer_key
JOIN gold.dim_date      AS d ON f.sold_date = d.sold_date;

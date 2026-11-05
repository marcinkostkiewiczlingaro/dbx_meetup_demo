-- Gold: conformed franchise (store) dimension, ready for analytics and Genie.
-- Joins the supplier name so an analyst can slice sales by supplier without a second hop.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_franchise
  COMMENT 'Conformed franchise (store) dimension for the sales star schema.'
AS
SELECT
  f.franchise_key,
  f.franchise_name,
  f.city,
  f.district,
  f.country,
  f.store_size,
  f.supplier_key,
  s.supplier_name,
  s.ingredient AS supplier_ingredient
FROM silver.dim_franchise AS f
LEFT JOIN silver.dim_supplier AS s ON f.supplier_key = s.supplier_key;

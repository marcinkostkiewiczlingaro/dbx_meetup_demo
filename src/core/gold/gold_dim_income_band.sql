-- Gold: conformed income-band dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_income_band; one row per income band.
-- Business domain: Customer (see docs/domains/README.md). The domain tag is carried in the
-- COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_income_band
  COMMENT 'Conformed income-band dimension for the star schema. domain=Customer'
AS
SELECT
  income_band_key,
  lower_bound,
  upper_bound
FROM silver.dim_income_band;

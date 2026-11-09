-- Gold: conformed household-demographics dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_household_demographics; one row per household profile.
-- Business domain: Customer (see docs/domains/README.md). The domain tag is carried in the
-- COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_household_demographics
  COMMENT 'Conformed household-demographics dimension for the star schema. domain=Customer'
AS
SELECT
  household_demographics_key,
  income_band_key,
  buy_potential,
  dependent_count,
  vehicle_count
FROM silver.dim_household_demographics;

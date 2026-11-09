-- Silver: cleansed household-demographics dimension with business column names.
-- Business key: household_demographics_key (the TPC-DS surrogate).
-- Keeps income_band_key as the link to silver.dim_income_band.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_household_demographics (
  CONSTRAINT valid_household_key EXPECT (household_demographics_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed household demographics with business names. Source: bronze.household_demographics.'
AS
SELECT
  hd_demo_sk        AS household_demographics_key,
  hd_income_band_sk AS income_band_key,
  hd_buy_potential  AS buy_potential,
  hd_dep_count      AS dependent_count,
  hd_vehicle_count  AS vehicle_count
FROM bronze.household_demographics;

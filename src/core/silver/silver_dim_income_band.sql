-- Silver: cleansed income-band dimension with business column names.
-- Business key: income_band_key (the TPC-DS surrogate), one row per band.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_income_band (
  CONSTRAINT valid_income_band_key EXPECT (income_band_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed income bands with business names. Source: bronze.income_band.'
AS
SELECT
  ib_income_band_sk AS income_band_key,
  ib_lower_bound    AS lower_bound,
  ib_upper_bound    AS upper_bound
FROM bronze.income_band;

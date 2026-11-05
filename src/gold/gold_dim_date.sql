-- Gold: conformed calendar dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_date; one row per calendar day.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_date
  COMMENT 'Conformed calendar dimension for the store-sales star schema.'
AS
SELECT
  date_key,
  calendar_date,
  calendar_year,
  month_of_year,
  quarter_of_year,
  day_name,
  is_weekend
FROM silver.dim_date;

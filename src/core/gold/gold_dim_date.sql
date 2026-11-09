-- Gold: conformed calendar dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_date; one row per calendar day.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_date
  COMMENT 'Conformed calendar dimension for the store-sales star schema. domain=Calendar'
AS
SELECT
  date_key,
  calendar_date,
  calendar_year,
  month_of_year,
  month_name,
  day_of_month,
  day_name,
  quarter_of_year,
  is_weekend,
  is_holiday
FROM silver.dim_date;

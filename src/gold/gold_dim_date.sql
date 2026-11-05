-- Gold: conformed calendar dimension, derived from the sales fact.
-- The bakehouse sample has no date table, so the calendar comes from the days with
-- sales. sold_date is the natural business key.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_date
  COMMENT 'Conformed calendar dimension, derived from silver.fct_sales.'
AS
SELECT DISTINCT
  sold_date,
  YEAR(sold_date)                              AS calendar_year,
  MONTH(sold_date)                             AS month_of_year,
  DATE_FORMAT(sold_date, 'MMMM')               AS month_name,
  DAY(sold_date)                               AS day_of_month,
  DATE_FORMAT(sold_date, 'EEEE')               AS day_name,
  DAYOFWEEK(sold_date) IN (1, 7)               AS is_weekend
FROM silver.fct_sales;

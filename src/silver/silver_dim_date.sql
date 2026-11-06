-- Silver: cleansed calendar dimension with business column names.
-- Business key: date_key (the TPC-DS surrogate), with calendar_date as the natural date.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_date (
  CONSTRAINT valid_date_key EXPECT (date_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed calendar with business names. Source: bronze.date_dim.'
AS
SELECT
  d_date_sk                         AS date_key,
  d_date                            AS calendar_date,
  d_year                            AS calendar_year,
  d_moy                             AS month_of_year,
  DATE_FORMAT(d_date, 'MMMM')       AS month_name,
  d_dom                             AS day_of_month,
  d_day_name                        AS day_name,
  d_qoy                             AS quarter_of_year,
  CAST(d_weekend = 'Y' AS BOOLEAN)  AS is_weekend,
  CAST(d_holiday = 'Y' AS BOOLEAN)  AS is_holiday
FROM bronze.date_dim;

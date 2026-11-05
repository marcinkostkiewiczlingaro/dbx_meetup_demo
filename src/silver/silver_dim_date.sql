-- Silver: cleansed calendar dimension with business column names.
-- Business key: date_key (one row per calendar day).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_date (
  CONSTRAINT valid_date_key EXPECT (date_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed calendar with business names. Source: bronze.date_dim.'
AS
SELECT
  d_date_sk       AS date_key,
  d_date          AS calendar_date,
  d_year          AS calendar_year,
  d_moy           AS month_of_year,
  d_qoy           AS quarter_of_year,
  d_day_name      AS day_name,
  CAST(d_weekend = 'Y' AS BOOLEAN) AS is_weekend
FROM bronze.date_dim;

-- Silver: cleansed time-of-day dimension with business column names.
-- Business key: time_key (the TPC-DS surrogate), one row per second of the day.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_time (
  CONSTRAINT valid_time_key EXPECT (time_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed time-of-day grid with business names. Source: bronze.time_dim.'
AS
SELECT
  t_time_sk     AS time_key,
  t_time        AS second_of_day,
  t_hour        AS hour_of_day,
  t_minute      AS minute_of_hour,
  t_second      AS second_of_minute,
  t_am_pm       AS am_pm,
  t_shift       AS shift,
  t_sub_shift   AS sub_shift,
  t_meal_time   AS meal_time
FROM bronze.time_dim;

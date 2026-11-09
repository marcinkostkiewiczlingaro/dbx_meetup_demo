-- Gold: conformed time-of-day dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_time; one row per second of the day.
-- Business domain: Calendar (see docs/domains/README.md). The domain tag is carried in the
-- COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_time
  COMMENT 'Conformed time-of-day dimension for the star schema. domain=Calendar'
AS
SELECT
  time_key,
  second_of_day,
  hour_of_day,
  minute_of_hour,
  second_of_minute,
  am_pm,
  shift,
  sub_shift,
  meal_time
FROM silver.dim_time;

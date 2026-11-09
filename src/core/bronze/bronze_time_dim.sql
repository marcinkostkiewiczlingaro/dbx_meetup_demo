-- Bronze: raw time-of-day dimension, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.time_dim. Resolves time surrogates to a wall-clock time.
CREATE OR REFRESH STREAMING TABLE bronze.time_dim
  COMMENT 'Raw time-of-day grid from the TPC-DS time_dim dimension.'
AS SELECT * FROM STREAM ${source_schema}.time_dim;

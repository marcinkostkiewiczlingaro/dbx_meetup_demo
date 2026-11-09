-- Bronze: raw household demographics, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.household_demographics. One row per household profile.
CREATE OR REFRESH STREAMING TABLE bronze.household_demographics
  COMMENT 'Raw household demographics from the TPC-DS household_demographics dimension.'
AS SELECT * FROM STREAM ${source_schema}.household_demographics;

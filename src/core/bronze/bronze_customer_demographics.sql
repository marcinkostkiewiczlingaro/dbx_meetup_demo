-- Bronze: raw customer demographics, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.customer_demographics. One row per demographic profile.
CREATE OR REFRESH STREAMING TABLE bronze.customer_demographics
  COMMENT 'Raw customer demographics from the TPC-DS customer_demographics dimension.'
AS SELECT * FROM STREAM ${source_schema}.customer_demographics;

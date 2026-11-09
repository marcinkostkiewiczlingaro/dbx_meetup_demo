-- Bronze: raw return reasons, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.reason. Explains why a sale was returned.
CREATE OR REFRESH STREAMING TABLE bronze.reason
  COMMENT 'Raw return reasons from the TPC-DS reason dimension.'
AS SELECT * FROM STREAM ${source_schema}.reason;

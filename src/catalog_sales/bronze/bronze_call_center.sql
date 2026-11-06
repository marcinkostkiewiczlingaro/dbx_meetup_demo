-- Bronze: raw call centers, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.call_center. Carries slowly-changing history; silver
-- keeps the current record.
CREATE OR REFRESH STREAMING TABLE bronze.call_center
  COMMENT 'Raw call centers from the TPC-DS call_center dimension.'
AS SELECT * FROM STREAM ${source_schema}.call_center;

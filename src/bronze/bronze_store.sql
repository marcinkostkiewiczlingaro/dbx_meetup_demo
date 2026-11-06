-- Bronze: raw stores, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.store. Carries slowly-changing history; silver keeps
-- the current record.
CREATE OR REFRESH STREAMING TABLE bronze.store
  COMMENT 'Raw stores from the TPC-DS store dimension.'
AS SELECT * FROM STREAM ${source_schema}.store;

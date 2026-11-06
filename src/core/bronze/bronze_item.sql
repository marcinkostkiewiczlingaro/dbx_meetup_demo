-- Bronze: raw items (products), copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.item. Carries slowly-changing history; silver keeps
-- the current record.
CREATE OR REFRESH STREAMING TABLE bronze.item
  COMMENT 'Raw items (products) from the TPC-DS item dimension.'
AS SELECT * FROM STREAM ${source_schema}.item;

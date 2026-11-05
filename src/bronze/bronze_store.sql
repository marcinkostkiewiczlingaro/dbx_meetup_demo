-- Bronze: raw store dimension, copied as-is from the Databricks TPC-DS sample.
-- Source of truth: samples.tpcds_sf1.store.
CREATE OR REFRESH STREAMING TABLE bronze.store
  COMMENT 'Raw stores from samples.tpcds_sf1.store.'
AS SELECT * FROM STREAM samples.tpcds_sf1.store;

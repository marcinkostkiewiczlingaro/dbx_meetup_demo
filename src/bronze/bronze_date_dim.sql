-- Bronze: raw date dimension, copied as-is from the Databricks TPC-DS sample.
-- Source of truth: samples.tpcds_sf1.date_dim.
CREATE OR REFRESH STREAMING TABLE bronze.date_dim
  COMMENT 'Raw calendar rows from samples.tpcds_sf1.date_dim.'
AS SELECT * FROM STREAM samples.tpcds_sf1.date_dim;

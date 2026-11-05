-- Bronze: raw item (product) dimension, copied as-is from the Databricks TPC-DS sample.
-- Source of truth: samples.tpcds_sf1.item.
CREATE OR REFRESH STREAMING TABLE bronze.item
  COMMENT 'Raw items from samples.tpcds_sf1.item.'
AS SELECT * FROM STREAM samples.tpcds_sf1.item;

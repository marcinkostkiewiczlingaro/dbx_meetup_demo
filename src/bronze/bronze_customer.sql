-- Bronze: raw customer dimension, copied as-is from the Databricks TPC-DS sample.
-- Source of truth: samples.tpcds_sf1.customer.
CREATE OR REFRESH STREAMING TABLE bronze.customer
  COMMENT 'Raw customers from samples.tpcds_sf1.customer.'
AS SELECT * FROM STREAM samples.tpcds_sf1.customer;

-- Bronze: raw store-sales fact, copied as-is from the Databricks TPC-DS sample.
-- Source of truth: samples.tpcds_sf1.store_sales (public Databricks sample data).
-- No renaming or typing here; bronze keeps the source shape for audit.
CREATE OR REFRESH STREAMING TABLE bronze.store_sales
  COMMENT 'Raw store-sales lines from samples.tpcds_sf1.store_sales.'
AS SELECT * FROM STREAM samples.tpcds_sf1.store_sales;

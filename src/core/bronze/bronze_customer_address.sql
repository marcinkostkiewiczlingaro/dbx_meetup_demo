-- Bronze: raw customer addresses, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.customer_address. Joined to customer in silver.
CREATE OR REFRESH STREAMING TABLE bronze.customer_address
  COMMENT 'Raw customer addresses from the TPC-DS customer_address dimension.'
AS SELECT * FROM STREAM ${source_schema}.customer_address;

-- Bronze: raw customers, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.customer.
CREATE OR REFRESH STREAMING TABLE bronze.customer
  COMMENT 'Raw customers from the TPC-DS customer dimension.'
AS SELECT * FROM STREAM ${source_schema}.customer;

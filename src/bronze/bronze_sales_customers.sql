-- Bronze: raw customers, copied as-is from the Databricks bakehouse sample.
-- Source of truth: samples.bakehouse.sales_customers.
CREATE OR REFRESH STREAMING TABLE bronze.sales_customers
  COMMENT 'Raw customers from samples.bakehouse.sales_customers.'
AS SELECT * FROM STREAM samples.bakehouse.sales_customers;

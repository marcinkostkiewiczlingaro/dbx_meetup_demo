-- Bronze: raw sales transactions, copied as-is from the Databricks bakehouse sample.
-- Source of truth: samples.bakehouse.sales_transactions (public Databricks sample data).
-- No renaming or typing here; bronze keeps the source shape for audit.
CREATE OR REFRESH STREAMING TABLE bronze.sales_transactions
  COMMENT 'Raw bakery sales lines from samples.bakehouse.sales_transactions.'
AS SELECT * FROM STREAM samples.bakehouse.sales_transactions;

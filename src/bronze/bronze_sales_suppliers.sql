-- Bronze: raw suppliers, copied as-is from the Databricks bakehouse sample.
-- Source of truth: samples.bakehouse.sales_suppliers.
CREATE OR REFRESH STREAMING TABLE bronze.sales_suppliers
  COMMENT 'Raw suppliers from samples.bakehouse.sales_suppliers.'
AS SELECT * FROM STREAM samples.bakehouse.sales_suppliers;

-- Bronze: raw franchises (the store locations), copied as-is from the bakehouse sample.
-- Source of truth: samples.bakehouse.sales_franchises.
CREATE OR REFRESH STREAMING TABLE bronze.sales_franchises
  COMMENT 'Raw franchises (stores) from samples.bakehouse.sales_franchises.'
AS SELECT * FROM STREAM samples.bakehouse.sales_franchises;

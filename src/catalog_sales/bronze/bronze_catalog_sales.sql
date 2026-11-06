-- Bronze: raw catalog-sales lines, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.catalog_sales (set by the source_schema bundle variable).
-- Grain: one catalog-sales order line (cs_order_number x cs_item_sk). Bronze keeps the
-- source shape for audit; no renaming or typing here.
CREATE OR REFRESH STREAMING TABLE bronze.catalog_sales
  COMMENT 'Raw catalog-sales lines from the TPC-DS catalog_sales fact.'
AS SELECT * FROM STREAM ${source_schema}.catalog_sales;

-- Bronze: raw web-sales lines, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.web_sales (set by the source_schema bundle variable).
-- Grain: one web-sales order line (ws_order_number x ws_item_sk). Bronze keeps the source
-- shape for audit; no renaming or typing here.
CREATE OR REFRESH STREAMING TABLE bronze.web_sales
  COMMENT 'Raw web-sales lines from the TPC-DS web_sales fact.'
AS SELECT * FROM STREAM ${source_schema}.web_sales;

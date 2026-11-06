-- Bronze: raw store-sales lines, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.store_sales (set by the source_schema bundle variable).
-- Grain: one store-sales ticket line (ss_ticket_number x ss_item_sk). Bronze keeps the
-- source shape for audit; no renaming or typing here.
CREATE OR REFRESH STREAMING TABLE bronze.store_sales
  COMMENT 'Raw store-sales lines from the TPC-DS store_sales fact.'
AS SELECT * FROM STREAM ${source_schema}.store_sales;

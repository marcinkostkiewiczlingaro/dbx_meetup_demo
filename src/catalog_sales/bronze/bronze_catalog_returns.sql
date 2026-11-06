-- Bronze: raw catalog-return lines, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.catalog_returns (set by the source_schema bundle variable).
-- Grain: one catalog-return line (cr_order_number x cr_item_sk). Bronze keeps the source
-- shape for audit; no renaming or typing here.
CREATE OR REFRESH STREAMING TABLE bronze.catalog_returns
  COMMENT 'Raw catalog-return lines from the TPC-DS catalog_returns fact.'
AS SELECT * FROM STREAM ${source_schema}.catalog_returns;

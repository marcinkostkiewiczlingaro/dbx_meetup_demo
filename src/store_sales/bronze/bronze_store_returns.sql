-- Bronze: raw store-return lines, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.store_returns (set by the source_schema bundle variable).
-- Grain: one store-return line (sr_ticket_number x sr_item_sk). Bronze keeps the source
-- shape for audit; no renaming or typing here.
CREATE OR REFRESH STREAMING TABLE bronze.store_returns
  COMMENT 'Raw store-return lines from the TPC-DS store_returns fact.'
AS SELECT * FROM STREAM ${source_schema}.store_returns;

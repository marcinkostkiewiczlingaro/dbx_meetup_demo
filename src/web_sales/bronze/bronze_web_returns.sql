-- Bronze: raw web-return lines, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.web_returns (set by the source_schema bundle variable).
-- Grain: one web-return line (wr_order_number x wr_item_sk). Bronze keeps the source shape
-- for audit; no renaming or typing here.
CREATE OR REFRESH STREAMING TABLE bronze.web_returns
  COMMENT 'Raw web-return lines from the TPC-DS web_returns fact.'
AS SELECT * FROM STREAM ${source_schema}.web_returns;

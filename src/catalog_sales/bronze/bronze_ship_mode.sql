-- Bronze: raw ship modes, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.ship_mode. The shipping method a catalog-sales line
-- was delivered by.
CREATE OR REFRESH STREAMING TABLE bronze.ship_mode
  COMMENT 'Raw ship modes from the TPC-DS ship_mode dimension.'
AS SELECT * FROM STREAM ${source_schema}.ship_mode;

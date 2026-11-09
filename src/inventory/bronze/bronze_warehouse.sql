-- Bronze: raw warehouses, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.warehouse. The stocking locations for inventory.
CREATE OR REFRESH STREAMING TABLE bronze.warehouse
  COMMENT 'Raw warehouses from the TPC-DS warehouse dimension.'
AS SELECT * FROM STREAM ${source_schema}.warehouse;

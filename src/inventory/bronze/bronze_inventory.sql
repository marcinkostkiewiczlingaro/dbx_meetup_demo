-- Bronze: raw inventory snapshots, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.inventory. Quantity on hand per item, warehouse, and date.
CREATE OR REFRESH STREAMING TABLE bronze.inventory
  COMMENT 'Raw periodic inventory snapshots from the TPC-DS inventory fact.'
AS SELECT * FROM STREAM ${source_schema}.inventory;

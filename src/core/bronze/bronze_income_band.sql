-- Bronze: raw income bands, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.income_band. Lower/upper income bounds per band.
CREATE OR REFRESH STREAMING TABLE bronze.income_band
  COMMENT 'Raw income bands from the TPC-DS income_band dimension.'
AS SELECT * FROM STREAM ${source_schema}.income_band;

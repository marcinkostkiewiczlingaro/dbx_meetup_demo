-- Bronze: raw calendar, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.date_dim. Resolves ss_sold_date_sk to a real date.
CREATE OR REFRESH STREAMING TABLE bronze.date_dim
  COMMENT 'Raw calendar from the TPC-DS date_dim dimension.'
AS SELECT * FROM STREAM ${source_schema}.date_dim;

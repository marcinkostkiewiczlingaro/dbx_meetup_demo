-- Silver: cleansed return-reason dimension with business column names.
-- Business key: reason_key (the TPC-DS surrogate), one row per reason.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_reason (
  CONSTRAINT valid_reason_key EXPECT (reason_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed return reasons with business names. Source: bronze.reason.'
AS
SELECT
  r_reason_sk   AS reason_key,
  r_reason_id   AS reason_id,
  r_reason_desc AS reason_description
FROM bronze.reason;

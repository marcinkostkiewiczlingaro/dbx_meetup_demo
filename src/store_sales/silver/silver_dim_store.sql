-- Silver: cleansed store dimension with business column names.
-- A store is the physical location where a store-sales line happens.
-- Business key: store_key (one row per store).
-- TPC-DS store carries slowly-changing history; keep only the current record.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_store (
  CONSTRAINT valid_store_key EXPECT (store_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed stores, current records only. Source: bronze.store.'
AS
SELECT
  s_store_sk        AS store_key,
  s_store_id        AS store_id,
  s_store_name      AS store_name,
  s_city            AS store_city,
  s_county          AS store_county,
  s_state           AS store_state,
  s_zip             AS store_zip,
  s_country         AS store_country,
  s_market_id       AS store_market_id,
  s_company_name    AS store_company,
  s_floor_space     AS floor_space,
  s_number_employees AS number_employees
FROM bronze.store
WHERE s_rec_end_date IS NULL;

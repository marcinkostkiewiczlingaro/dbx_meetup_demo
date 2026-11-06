-- Silver: cleansed call-center dimension with business column names.
-- A call center is where a catalog-sales order is taken. Business key: call_center_key.
-- TPC-DS call_center carries slowly-changing history; keep only the current record.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_call_center (
  CONSTRAINT valid_call_center_key EXPECT (call_center_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed call centers, current records only. Source: bronze.call_center.'
AS
SELECT
  cc_call_center_sk  AS call_center_key,
  cc_call_center_id  AS call_center_id,
  cc_name            AS call_center_name,
  cc_class           AS call_center_class,
  cc_manager         AS call_center_manager,
  cc_city            AS call_center_city,
  cc_state           AS call_center_state,
  cc_country         AS call_center_country,
  cc_company_name    AS call_center_company,
  cc_employees       AS number_employees
FROM bronze.call_center
WHERE cc_rec_end_date IS NULL;

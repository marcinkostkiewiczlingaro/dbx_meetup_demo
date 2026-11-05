-- Silver: cleansed customer dimension with business column names.
-- Renames TPC-DS codes to the shared vocabulary used by the ontology and metrics.
-- Business key: customer_key (one row per customer).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_customer (
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed customers with business names. Source: bronze.customer.'
AS
SELECT
  c_customer_sk        AS customer_key,
  c_customer_id        AS customer_id,
  c_first_name         AS first_name,
  c_last_name          AS last_name,
  c_preferred_cust_flag AS is_preferred_customer,
  c_birth_country      AS birth_country,
  c_email_address      AS email_address
FROM bronze.customer;

-- Silver: cleansed customer dimension with business column names.
-- Renames bakehouse codes to the shared vocabulary used by the ontology and metrics.
-- Business key: customer_key (one row per customer).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_customer (
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed customers with business names. Source: bronze.sales_customers.'
AS
SELECT
  customerID       AS customer_key,
  first_name       AS first_name,
  last_name        AS last_name,
  email_address    AS email_address,
  city             AS city,
  state            AS state,
  country          AS country,
  continent        AS continent,
  gender           AS gender
FROM bronze.sales_customers;

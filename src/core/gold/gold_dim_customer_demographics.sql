-- Gold: conformed customer-demographics dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_customer_demographics; one row per demographic profile.
-- Business domain: Customer (see docs/domains/README.md). The domain tag is carried in the
-- COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_customer_demographics
  COMMENT 'Conformed customer-demographics dimension for the star schema. domain=Customer'
AS
SELECT
  customer_demographics_key,
  gender,
  marital_status,
  education_status,
  purchase_estimate,
  credit_rating,
  dependent_count,
  dependent_employed_count,
  dependent_college_count
FROM silver.dim_customer_demographics;

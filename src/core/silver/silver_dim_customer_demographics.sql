-- Silver: cleansed customer-demographics dimension with business column names.
-- Business key: customer_demographics_key (the TPC-DS surrogate).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_customer_demographics (
  CONSTRAINT valid_demographics_key EXPECT (customer_demographics_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed customer demographics with business names. Source: bronze.customer_demographics.'
AS
SELECT
  cd_demo_sk            AS customer_demographics_key,
  cd_gender             AS gender,
  cd_marital_status     AS marital_status,
  cd_education_status   AS education_status,
  cd_purchase_estimate  AS purchase_estimate,
  cd_credit_rating      AS credit_rating,
  cd_dep_count          AS dependent_count,
  cd_dep_employed_count AS dependent_employed_count,
  cd_dep_college_count  AS dependent_college_count
FROM bronze.customer_demographics;

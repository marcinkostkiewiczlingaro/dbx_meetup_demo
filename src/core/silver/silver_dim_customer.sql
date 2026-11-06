-- Silver: cleansed customer dimension with business column names.
-- Joins the customer and its current address into one row per customer.
-- Business key: customer_key (one row per customer).
-- email_address stays in silver for lineage and is not published to gold (governance).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_customer (
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed customers with current address. Source: bronze.customer + bronze.customer_address.'
AS
SELECT
  c.c_customer_sk                              AS customer_key,
  c.c_customer_id                              AS customer_id,
  c.c_first_name                               AS first_name,
  c.c_last_name                                AS last_name,
  c.c_email_address                            AS email_address,
  c.c_birth_country                            AS birth_country,
  CAST(c.c_preferred_cust_flag = 'Y' AS BOOLEAN) AS is_preferred_customer,
  a.ca_city                                    AS customer_city,
  a.ca_county                                  AS customer_county,
  a.ca_state                                   AS customer_state,
  a.ca_zip                                     AS customer_zip,
  a.ca_country                                 AS customer_country
FROM bronze.customer AS c
LEFT JOIN bronze.customer_address AS a ON c.c_current_addr_sk = a.ca_address_sk;

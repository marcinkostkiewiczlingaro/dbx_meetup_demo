-- Gold: conformed customer dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_customer; one row per customer.
-- email_address stops at silver (governance); only business-safe columns reach gold.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_customer
  COMMENT 'Conformed customer dimension for the store-sales star schema.'
AS
SELECT
  customer_key,
  customer_id,
  first_name,
  last_name,
  birth_country,
  is_preferred_customer,
  customer_city,
  customer_county,
  customer_state,
  customer_zip,
  customer_country
FROM silver.dim_customer;

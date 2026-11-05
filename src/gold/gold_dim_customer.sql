-- Gold: conformed customer dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_customer; one row per customer.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_customer
  COMMENT 'Conformed customer dimension for the store-sales star schema.'
AS
SELECT
  customer_key,
  customer_id,
  first_name,
  last_name,
  is_preferred_customer,
  birth_country
FROM silver.dim_customer;

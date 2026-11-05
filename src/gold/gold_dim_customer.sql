-- Gold: conformed customer dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_customer; one row per customer.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_customer
  COMMENT 'Conformed customer dimension for the sales star schema.'
AS
SELECT
  customer_key,
  first_name,
  last_name,
  city,
  state,
  country,
  continent,
  gender
FROM silver.dim_customer;

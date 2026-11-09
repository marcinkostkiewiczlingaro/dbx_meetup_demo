-- Gold: conformed call-center dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_call_center; one row per call center.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_call_center
  COMMENT 'Conformed call-center dimension for the catalog-sales star schema. domain=Catalog Sales'
AS
SELECT
  call_center_key,
  call_center_id,
  call_center_name,
  call_center_class,
  call_center_manager,
  call_center_city,
  call_center_state,
  call_center_country,
  call_center_company,
  number_employees
FROM silver.dim_call_center;

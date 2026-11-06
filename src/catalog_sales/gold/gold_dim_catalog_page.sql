-- Gold: conformed catalog-page dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_catalog_page; one row per catalog page.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_catalog_page
  COMMENT 'Conformed catalog-page dimension for the catalog-sales star schema.'
AS
SELECT
  catalog_page_key,
  catalog_page_id,
  catalog_department,
  catalog_number,
  catalog_page_number,
  page_type,
  page_description
FROM silver.dim_catalog_page;

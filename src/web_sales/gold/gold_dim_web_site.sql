-- Gold: conformed web-site dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_web_site; one row per web site.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_web_site
  COMMENT 'Conformed web-site dimension for the web-sales star schema.'
AS
SELECT
  web_site_key,
  web_site_id,
  web_site_name,
  web_site_class,
  web_site_manager,
  web_site_city,
  web_site_state,
  web_site_country,
  web_site_company
FROM silver.dim_web_site;

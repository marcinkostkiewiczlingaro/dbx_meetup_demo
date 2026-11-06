-- Silver: cleansed web-site dimension with business column names.
-- A web site is the online storefront a web-sales line was ordered through.
-- Business key: web_site_key. TPC-DS web_site carries slowly-changing history; keep only
-- the current record.
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_web_site (
  CONSTRAINT valid_web_site_key EXPECT (web_site_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed web sites, current records only. Source: bronze.web_site.'
AS
SELECT
  web_site_sk      AS web_site_key,
  web_site_id      AS web_site_id,
  web_name         AS web_site_name,
  web_class        AS web_site_class,
  web_manager      AS web_site_manager,
  web_city         AS web_site_city,
  web_state        AS web_site_state,
  web_country      AS web_site_country,
  web_company_name AS web_site_company
FROM bronze.web_site
WHERE web_rec_end_date IS NULL;

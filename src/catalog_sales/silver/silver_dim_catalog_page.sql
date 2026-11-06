-- Silver: cleansed catalog-page dimension with business column names.
-- A catalog page is the printed-catalog page a catalog-sales line was ordered from.
-- Business key: catalog_page_key (one row per catalog page).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_catalog_page (
  CONSTRAINT valid_catalog_page_key EXPECT (catalog_page_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed catalog pages with business names. Source: bronze.catalog_page.'
AS
SELECT
  cp_catalog_page_sk     AS catalog_page_key,
  cp_catalog_page_id     AS catalog_page_id,
  cp_department          AS catalog_department,
  cp_catalog_number      AS catalog_number,
  cp_catalog_page_number AS catalog_page_number,
  cp_type                AS page_type,
  cp_description         AS page_description
FROM bronze.catalog_page;

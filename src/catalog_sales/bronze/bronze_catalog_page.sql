-- Bronze: raw catalog pages, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.catalog_page. A catalog page is the page of the printed
-- catalog a catalog-sales line was ordered from.
CREATE OR REFRESH STREAMING TABLE bronze.catalog_page
  COMMENT 'Raw catalog pages from the TPC-DS catalog_page dimension.'
AS SELECT * FROM STREAM ${source_schema}.catalog_page;

-- Bronze: raw web pages, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.web_page. A web page is the site page a web-sales line
-- was ordered from. Carries slowly-changing history; silver keeps the current record.
CREATE OR REFRESH STREAMING TABLE bronze.web_page
  COMMENT 'Raw web pages from the TPC-DS web_page dimension.'
AS SELECT * FROM STREAM ${source_schema}.web_page;

-- Bronze: raw web sites, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.web_site. Carries slowly-changing history; silver keeps
-- the current record.
CREATE OR REFRESH STREAMING TABLE bronze.web_site
  COMMENT 'Raw web sites from the TPC-DS web_site dimension.'
AS SELECT * FROM STREAM ${source_schema}.web_site;

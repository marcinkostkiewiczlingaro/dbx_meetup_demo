-- Gold: conformed return-reason dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_reason; one row per return reason.
-- Business domain: Shipping & Returns Reference (see docs/domains/README.md). The domain tag
-- is carried in the COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is
-- not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_reason
  COMMENT 'Conformed return-reason dimension for the returns facts. domain=Shipping & Returns Reference'
AS
SELECT
  reason_key,
  reason_id,
  reason_description
FROM silver.dim_reason;

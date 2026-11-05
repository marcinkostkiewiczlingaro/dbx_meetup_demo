-- Silver: cleansed store dimension with business column names.
-- Business key: store_key (one row per store version).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_store (
  CONSTRAINT valid_store_key EXPECT (store_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed stores with business names. Source: bronze.store.'
AS
SELECT
  s_store_sk     AS store_key,
  s_store_id     AS store_id,
  s_store_name   AS store_name,
  s_city         AS city,
  s_state        AS state,
  s_country      AS country,
  s_floor_space  AS floor_space_sqft
FROM bronze.store;

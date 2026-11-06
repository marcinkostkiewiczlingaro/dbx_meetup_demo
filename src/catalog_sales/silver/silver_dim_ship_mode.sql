-- Silver: cleansed ship-mode dimension with business column names.
-- A ship mode is the shipping method a catalog-sales line was delivered by.
-- Business key: ship_mode_key (one row per ship mode).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_ship_mode (
  CONSTRAINT valid_ship_mode_key EXPECT (ship_mode_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed ship modes with business names. Source: bronze.ship_mode.'
AS
SELECT
  sm_ship_mode_sk AS ship_mode_key,
  sm_ship_mode_id AS ship_mode_id,
  sm_type         AS ship_mode_type,
  sm_code         AS ship_mode_code,
  sm_carrier      AS carrier
FROM bronze.ship_mode;

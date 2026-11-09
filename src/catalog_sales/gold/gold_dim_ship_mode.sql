-- Gold: conformed ship-mode dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_ship_mode; one row per ship mode.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_ship_mode
  COMMENT 'Conformed ship-mode dimension for the catalog-sales star schema. domain=Shipping & Returns Reference'
AS
SELECT
  ship_mode_key,
  ship_mode_id,
  ship_mode_type,
  ship_mode_code,
  carrier
FROM silver.dim_ship_mode;

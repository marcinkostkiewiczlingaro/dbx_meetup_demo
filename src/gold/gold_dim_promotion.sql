-- Gold: conformed promotion dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_promotion; one row per promotion.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_promotion
  COMMENT 'Conformed promotion dimension for the store-sales star schema.'
AS
SELECT
  promo_key,
  promo_id,
  promo_name,
  promo_purpose,
  promo_cost,
  is_discount_active,
  channel_email,
  channel_tv
FROM silver.dim_promotion;

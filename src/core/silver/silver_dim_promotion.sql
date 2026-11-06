-- Silver: cleansed promotion dimension with business column names.
-- A promotion is a marketing campaign a store-sales line may be attributed to.
-- Business key: promo_key (one row per promotion).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_promotion (
  CONSTRAINT valid_promo_key EXPECT (promo_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed promotions with business names. Source: bronze.promotion.'
AS
SELECT
  p_promo_sk                             AS promo_key,
  p_promo_id                             AS promo_id,
  p_promo_name                           AS promo_name,
  p_purpose                              AS promo_purpose,
  p_cost                                 AS promo_cost,
  CAST(p_discount_active = 'Y' AS BOOLEAN) AS is_discount_active,
  CAST(p_channel_email = 'Y' AS BOOLEAN)   AS channel_email,
  CAST(p_channel_tv = 'Y' AS BOOLEAN)      AS channel_tv
FROM bronze.promotion;

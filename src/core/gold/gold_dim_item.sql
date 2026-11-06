-- Gold: conformed item (product) dimension, ready for analytics and Genie.
-- Presentation copy of silver.dim_item; one row per item.
CREATE OR REFRESH MATERIALIZED VIEW gold.dim_item
  COMMENT 'Conformed item (product) dimension for the store-sales star schema.'
AS
SELECT
  item_key,
  item_id,
  item_name,
  item_description,
  brand,
  class,
  category,
  manufacturer,
  current_price,
  wholesale_cost
FROM silver.dim_item;

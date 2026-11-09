-- Silver: cleansed inventory fact with business column names.
-- Grain: one row per item x warehouse x date snapshot (a periodic stock snapshot).
-- Resolves the snapshot-date surrogate to a real date through bronze.date_dim.
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_inventory (
  CONSTRAINT valid_item_key      EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_warehouse_key EXPECT (warehouse_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_date_key      EXPECT (date_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed periodic inventory snapshots. Source: bronze.inventory + bronze.date_dim.'
AS
SELECT
  inv.inv_item_sk          AS item_key,
  inv.inv_warehouse_sk     AS warehouse_key,
  inv.inv_date_sk          AS date_key,
  d.d_date                 AS snapshot_date,
  inv.inv_quantity_on_hand AS quantity_on_hand
FROM bronze.inventory AS inv
LEFT JOIN bronze.date_dim AS d ON inv.inv_date_sk = d.d_date_sk;

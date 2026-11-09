-- Gold: conformed inventory fact for the star schema.
-- Grain: one row per item x warehouse x date snapshot (a periodic stock snapshot).
-- Inner joins to the conformed item, warehouse, and date dims keep only referentially clean
-- rows. dim_item and dim_date are owned by the core pipeline; dim_warehouse by this pipeline.
-- No dimension is rebuilt here except dim_warehouse (reads across pipelines are allowed).
-- Business domain: Inventory (see docs/domains/README.md). The domain tag is carried in the
-- COMMENT because applying Unity Catalog tags inside a Lakeflow pipeline is not reliable.
CREATE OR REFRESH MATERIALIZED VIEW gold.fct_inventory
  COMMENT 'Conformed inventory fact. Grain: item x warehouse x date snapshot. domain=Inventory'
AS
SELECT
  f.item_key,
  f.warehouse_key,
  f.date_key,
  f.snapshot_date,
  f.quantity_on_hand
FROM silver.fct_inventory AS f
JOIN gold.dim_item      AS i ON f.item_key      = i.item_key
JOIN gold.dim_warehouse AS w ON f.warehouse_key = w.warehouse_key
JOIN gold.dim_date      AS d ON f.date_key      = d.date_key;

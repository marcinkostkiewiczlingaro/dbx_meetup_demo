---
c4_level: 3
module: inventory
component: gold
entities: [FctInventory, DimWarehouse]
tables: [gold.fct_inventory, gold.dim_warehouse]
---
# Gold — Inventory Star Schema

| module | component | entities | tables |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | gold | FctInventory · DimWarehouse | [gold.fct_inventory](../../reference/tables/gold.fct_inventory.md) · [gold.dim_warehouse](../../reference/tables/gold.dim_warehouse.md) |

> **C4 Level 3 — Component.** The conformed inventory fact and warehouse dimension. The fact joins the conformed item and date gold dims built by the core pipeline; it rebuilds no dimension except `dim_warehouse`.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctInventory` | [`gold.fct_inventory`](../../reference/tables/gold.fct_inventory.md) | — | Periodic stock-snapshot fact; grain item × warehouse × date. Business domain: Inventory. |
| `DimWarehouse` | [`gold.dim_warehouse`](../../reference/tables/gold.dim_warehouse.md) | — | Warehouse dimension. Business domain: Inventory. |

Each entity is one SQL file in `src/inventory/gold/`. `fct_inventory` inner-joins
`gold.dim_item`, `gold.dim_warehouse`, and `gold.dim_date` to keep only referentially clean
rows (reads across pipelines are allowed; writes are not). The domain each table belongs to
is recorded in the [domains registry](../../domains/README.md) and carried on each table as a
`domain=<Name>` marker in its `COMMENT`.

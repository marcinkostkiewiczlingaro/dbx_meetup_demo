---
c4_level: 3
module: inventory
component: silver
entities: [FctInventory, DimWarehouse]
tables: [silver.fct_inventory, silver.dim_warehouse]
---
# Silver — Cleansed, Business-Named (Inventory)

| module | component | entities | tables |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | silver | FctInventory · DimWarehouse | silver.fct_inventory · silver.dim_warehouse |

> **C4 Level 3 — Component.** The cleansed inventory fact and warehouse dimension with business column names and quality checks.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctInventory` | `silver.fct_inventory` | — | Periodic stock snapshot; resolves the snapshot-date surrogate to a real date. |
| `DimWarehouse` | `silver.dim_warehouse` | — | Warehouse (stocking location) with business names. |

Each entity is one SQL file in `src/inventory/silver/`. The fact's key columns carry
`EXPECT` constraints that drop referentially broken rows. The grain is one
`item_key × warehouse_key × date_key` snapshot of `quantity_on_hand`.

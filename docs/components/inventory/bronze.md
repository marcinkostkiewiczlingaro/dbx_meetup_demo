---
c4_level: 3
module: inventory
component: bronze
entities: [InventoryRaw, WarehouseRaw]
tables: [bronze.inventory, bronze.warehouse]
---
# Bronze — Raw Ingest (Inventory)

| module | component | entities | tables |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | bronze | InventoryRaw · WarehouseRaw | bronze.inventory · bronze.warehouse |

> **C4 Level 3 — Component.** Streaming copies of the TPC-DS inventory fact and warehouse dimension, kept in the source shape for audit. The source schema is the `${source_schema}` pipeline configuration.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `InventoryRaw` | `bronze.inventory` | — | Raw periodic snapshots of quantity on hand per item, warehouse, and date. |
| `WarehouseRaw` | `bronze.warehouse` | — | Raw warehouses, the stocking locations for inventory. |

Each entity is one SQL file in `src/inventory/bronze/`. Bronze does no renaming or typing;
it reads `FROM STREAM ${source_schema}.<table>`, so the same pipeline can target the 1 GB
`sf1` sample or the 1 TB `sf1000` sample.

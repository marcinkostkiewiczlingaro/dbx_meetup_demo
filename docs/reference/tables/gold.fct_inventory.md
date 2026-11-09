---
c4_level: 4
type: table_schema
database: gold
table: fct_inventory
component: components/inventory/gold.md
partition_columns: []
data_layer: Gold (fact)
---
# gold.fct_inventory

| module | component | table | pipeline |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | [gold](../../components/inventory/gold.md) | gold.fct_inventory | ← [silver.fct_inventory](../../components/inventory/silver.md) · [gold.dim_item](./gold.dim_item.md) · [gold.dim_warehouse](./gold.dim_warehouse.md) · [gold.dim_date](./gold.dim_date.md) |

> **C4 Level 4 — Table.** Conformed inventory fact, a periodic stock snapshot. Grain: one item × warehouse × date snapshot. Business domain: Inventory (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `item_key` | int | Link to `gold.dim_item`. |
| `warehouse_key` | int | Link to `gold.dim_warehouse`. |
| `date_key` | int | Link to `gold.dim_date` (the snapshot date). |
| `snapshot_date` | date | The calendar day of the snapshot. |
| `quantity_on_hand` | int | Units in stock for the item at the warehouse on that date. |

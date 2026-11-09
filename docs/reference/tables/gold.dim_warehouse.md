---
c4_level: 4
type: table_schema
database: gold
table: dim_warehouse
component: components/inventory/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_warehouse

| module | component | table | pipeline |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | [gold](../../components/inventory/gold.md) | gold.dim_warehouse | ← [silver.dim_warehouse](../../components/inventory/silver.md) · → [gold.fct_inventory](./gold.fct_inventory.md) |

> **C4 Level 4 — Table.** Conformed warehouse dimension, one row per warehouse. Business domain: Inventory (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `warehouse_key` | int | Business key, the warehouse surrogate. |
| `warehouse_id` | string | Natural warehouse code. |
| `warehouse_name` | string | Warehouse name. |
| `warehouse_sq_ft` | int | Floor area in square feet. |
| `warehouse_city` | string | City. |
| `warehouse_county` | string | County. |
| `warehouse_state` | string | State. |
| `warehouse_zip` | string | ZIP code. |
| `warehouse_country` | string | Country. |
| `gmt_offset` | decimal | GMT offset of the warehouse location. |

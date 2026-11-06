---
c4_level: 4
type: table_schema
database: gold
table: dim_ship_mode
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_ship_mode

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.dim_ship_mode | ← [silver.dim_ship_mode](../../components/catalog_sales/silver.md) · → [gold.fct_catalog_sales](./gold.fct_catalog_sales.md) |

> **C4 Level 4 — Table.** Conformed ship-mode dimension, one row per ship mode.

## Columns

| Column | Type | Meaning |
|---|---|---|
| `ship_mode_key` | int | Business key, one per ship mode. |
| `ship_mode_id` | string | Natural ship-mode id. |
| `ship_mode_type` | string | Type of shipping method. |
| `ship_mode_code` | string | Ship-mode code. |
| `carrier` | string | Carrier that ships the order. |

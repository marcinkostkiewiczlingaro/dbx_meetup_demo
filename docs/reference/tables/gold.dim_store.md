---
c4_level: 4
type: table_schema
database: gold
table: dim_store
component: components/store_sales/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_store

| module | component | table | pipeline |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [gold](../../components/store_sales/gold.md) | gold.dim_store | ← [silver.dim_store](../../components/store_sales/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** Conformed store dimension, one row per store (current records only).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `store_key` | int | Business key, one per store. |
| `store_id` | string | Natural store id. |
| `store_name` | string | Store name. |
| `store_city` | string | City of the store. |
| `store_county` | string | County of the store. |
| `store_state` | string | State of the store. |
| `store_zip` | string | ZIP of the store. |
| `store_country` | string | Country of the store. |
| `store_market_id` | int | Market the store belongs to. |
| `store_company` | string | Company name. |
| `floor_space` | int | Floor space of the store. |
| `number_employees` | int | Number of employees. |

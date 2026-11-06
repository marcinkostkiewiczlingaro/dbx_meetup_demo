---
c4_level: 4
type: table_schema
database: gold
table: dim_item
component: components/pipeline/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_item

| module | component | table | pipeline |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | [gold](../../components/pipeline/gold.md) | gold.dim_item | ← [silver.dim_item](../../components/pipeline/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** Conformed item (product) dimension, one row per item (current records only).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `item_key` | int | Business key, one per item. |
| `item_id` | string | Natural item id. |
| `item_name` | string | Product name. |
| `item_description` | string | Product description. |
| `brand` | string | Brand. |
| `class` | string | Class within the category. |
| `category` | string | Category. |
| `manufacturer` | string | Manufacturer. |
| `current_price` | decimal | Current list price. |
| `wholesale_cost` | decimal | Wholesale cost. |

---
c4_level: 4
type: table_schema
database: gold
table: dim_item
domain: Retail Analytics/Shared Dimensions
object_type: Item
primary_key: item_key
source_of_truth: ${source_schema}.item
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_item

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_item | ← [silver.dim_item](../../components/core/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** The **Item** business object: a product offered for sale. Conformed item dimension, one row per item (current records only).

- **Primary key:** `item_key`
- **Source of truth:** `${source_schema}.item` (current records only)

## Columns

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `item_key` | int | `i_item_sk` | Business key, one per item. |
| `item_id` | string | `i_item_id` | Natural item id. |
| `item_name` | string | `i_product_name` | Product name. |
| `item_description` | string | `i_item_desc` | Product description. |
| `brand` | string | `i_brand` | Brand. |
| `class` | string | `i_class` | Class within the category. |
| `category` | string | `i_category` | Category. |
| `manufacturer` | string | `i_manufact` | Manufacturer. |
| `current_price` | decimal | `i_current_price` | Current list price. |
| `wholesale_cost` | decimal | `i_wholesale_cost` | Wholesale cost. |

## Links

- **Is sold in** many [`gold.fct_store_sales`](./gold.fct_store_sales.md) via `item_key` (one item → many store-sales lines).

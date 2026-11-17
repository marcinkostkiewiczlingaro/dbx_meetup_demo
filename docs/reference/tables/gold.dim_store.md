---
c4_level: 4
type: table_schema
database: gold
table: dim_store
domain: Retail Analytics/Shared Dimensions
object_type: Store
primary_key: store_key
source_of_truth: ${source_schema}.store
component: components/store_sales/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_store

| module | component | table | pipeline |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [gold](../../components/store_sales/gold.md) | gold.dim_store | ← [silver.dim_store](../../components/store_sales/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** The **Store** business object: a physical store where store sales happen. Conformed store dimension, one row per store (current records only).

- **Primary key:** `store_key`
- **Source of truth:** `${source_schema}.store` (current records only)

## Columns

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `store_key` | int | `s_store_sk` | Business key, one per store. |
| `store_id` | string | `s_store_id` | Natural store id. |
| `store_name` | string | `s_store_name` | Store name. |
| `store_city` | string | `s_city` | City of the store. |
| `store_county` | string | `s_county` | County of the store. |
| `store_state` | string | `s_state` | State of the store. |
| `store_zip` | string | `s_zip` | ZIP of the store. |
| `store_country` | string | `s_country` | Country of the store. |
| `store_market_id` | int | `s_market_id` | Market the store belongs to. |
| `store_company` | string | `s_company_name` | Company name. |
| `floor_space` | int | `s_floor_space` | Floor space of the store. |
| `number_employees` | int | `s_number_employees` | Number of employees. |

## Links

- **Hosts** many [`gold.fct_store_sales`](./gold.fct_store_sales.md) via `store_key` (one store → many store-sales lines).

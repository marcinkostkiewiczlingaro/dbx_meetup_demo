---
c4_level: 4
type: table_schema
database: gold
table: dim_customer
component: components/pipeline/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_customer

| module | component | table | pipeline |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | [gold](../../components/pipeline/gold.md) | gold.dim_customer | ← [silver.dim_customer](../../components/pipeline/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** Conformed customer dimension, one row per customer. `email_address` stops at silver (governance).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `customer_key` | int | Business key, one per customer. |
| `customer_id` | string | Natural customer id. |
| `first_name` | string | Given name. |
| `last_name` | string | Family name. |
| `birth_country` | string | Country of birth. |
| `is_preferred_customer` | boolean | Preferred-customer flag. |
| `customer_city` | string | City of the customer's address. |
| `customer_county` | string | County of the address. |
| `customer_state` | string | State of the address. |
| `customer_zip` | string | ZIP of the address. |
| `customer_country` | string | Country of the address. |

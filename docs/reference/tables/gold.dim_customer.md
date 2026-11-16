---
c4_level: 4
type: table_schema
database: gold
table: dim_customer
object_type: Customer
primary_key: customer_key
source_of_truth: ${source_schema}.customer + ${source_schema}.customer_address
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_customer

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_customer | ← [silver.dim_customer](../../components/core/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** The **Customer** business object: a person who buys from a store. Conformed customer dimension, one row per customer. `email_address` stops at silver (governance).

- **Primary key:** `customer_key`
- **Source of truth:** `${source_schema}.customer` + `${source_schema}.customer_address`

## Columns

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `customer_key` | int | `c_customer_sk` | Business key, one per customer. |
| `customer_id` | string | `c_customer_id` | Natural customer id. |
| `first_name` | string | `c_first_name` | Given name. |
| `last_name` | string | `c_last_name` | Family name. |
| `birth_country` | string | `c_birth_country` | Country of birth. |
| `is_preferred_customer` | boolean | `c_preferred_cust_flag` | Preferred-customer flag. |
| `customer_city` | string | `ca_city` | City of the customer's address. |
| `customer_county` | string | `ca_county` | County of the address. |
| `customer_state` | string | `ca_state` | State of the address. |
| `customer_zip` | string | `ca_zip` | ZIP of the address. |
| `customer_country` | string | `ca_country` | Country of the address. |

## Links

- **Makes** many [`gold.fct_store_sales`](./gold.fct_store_sales.md) via `customer_key` (one customer → many store-sales lines).

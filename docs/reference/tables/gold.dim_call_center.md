---
c4_level: 4
type: table_schema
database: gold
table: dim_call_center
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_call_center

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.dim_call_center | ← [silver.dim_call_center](../../components/catalog_sales/silver.md) · → [gold.fct_catalog_sales](./gold.fct_catalog_sales.md) |

> **C4 Level 4 — Table.** Conformed call-center dimension, one row per call center (current records only).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `call_center_key` | int | Business key, one per call center. |
| `call_center_id` | string | Natural call-center id. |
| `call_center_name` | string | Call-center name. |
| `call_center_class` | string | Class of the call center. |
| `call_center_manager` | string | Manager of the call center. |
| `call_center_city` | string | City of the call center. |
| `call_center_state` | string | State of the call center. |
| `call_center_country` | string | Country of the call center. |
| `call_center_company` | string | Company name. |
| `number_employees` | int | Number of employees. |

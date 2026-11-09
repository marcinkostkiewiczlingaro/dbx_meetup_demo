---
c4_level: 4
type: table_schema
database: gold
table: dim_customer_demographics
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_customer_demographics

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_customer_demographics | ← [silver.dim_customer_demographics](../../components/core/silver.md) |

> **C4 Level 4 — Table.** Conformed customer-demographics dimension, one row per demographic profile. Business domain: Customer (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `customer_demographics_key` | int | Business key, the demographic surrogate. |
| `gender` | string | Gender code. |
| `marital_status` | string | Marital-status code. |
| `education_status` | string | Highest education level. |
| `purchase_estimate` | int | Estimated annual purchase amount. |
| `credit_rating` | string | Credit-rating band. |
| `dependent_count` | int | Number of dependents. |
| `dependent_employed_count` | int | Number of employed dependents. |
| `dependent_college_count` | int | Number of dependents in college. |

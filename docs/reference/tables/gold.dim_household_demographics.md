---
c4_level: 4
type: table_schema
database: gold
table: dim_household_demographics
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_household_demographics

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_household_demographics | ← [silver.dim_household_demographics](../../components/core/silver.md) · → [gold.dim_income_band](./gold.dim_income_band.md) |

> **C4 Level 4 — Table.** Conformed household-demographics dimension, one row per household profile. Business domain: Customer (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `household_demographics_key` | int | Business key, the household surrogate. |
| `income_band_key` | int | Link to `gold.dim_income_band`. |
| `buy_potential` | string | Expected spending band. |
| `dependent_count` | int | Number of dependents in the household. |
| `vehicle_count` | int | Number of vehicles in the household. |

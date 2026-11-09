---
c4_level: 4
type: table_schema
database: gold
table: dim_income_band
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_income_band

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_income_band | ← [silver.dim_income_band](../../components/core/silver.md) |

> **C4 Level 4 — Table.** Conformed income-band dimension, one row per income band. Business domain: Customer (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `income_band_key` | int | Business key, the income-band surrogate. |
| `lower_bound` | int | Lower income bound of the band. |
| `upper_bound` | int | Upper income bound of the band. |

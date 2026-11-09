---
c4_level: 4
type: table_schema
database: gold
table: dim_reason
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_reason

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_reason | ← [silver.dim_reason](../../components/core/silver.md) |

> **C4 Level 4 — Table.** Conformed return-reason dimension, one row per reason. Business domain: Shipping & Returns Reference (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `reason_key` | int | Business key, the reason surrogate. |
| `reason_id` | string | Natural reason code. |
| `reason_description` | string | Business description of the return reason. |

---
c4_level: 4
type: table_schema
database: gold
table: dim_date
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_date

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_date | ← [silver.dim_date](../../components/core/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** Conformed calendar dimension, one row per calendar day.

## Columns

| Column | Type | Meaning |
|---|---|---|
| `date_key` | int | Business key, the sold-date surrogate. |
| `calendar_date` | date | The calendar day. |
| `calendar_year` | int | Year. |
| `month_of_year` | int | Month number (1–12). |
| `month_name` | string | Month name. |
| `day_of_month` | int | Day of the month. |
| `day_name` | string | Day name. |
| `quarter_of_year` | int | Quarter number (1–4). |
| `is_weekend` | boolean | Whether the day is a weekend. |
| `is_holiday` | boolean | Whether the day is a holiday. |

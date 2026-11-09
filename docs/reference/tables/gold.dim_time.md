---
c4_level: 4
type: table_schema
database: gold
table: dim_time
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_time

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_time | ← [silver.dim_time](../../components/core/silver.md) |

> **C4 Level 4 — Table.** Conformed time-of-day dimension, one row per second of the day. Business domain: Calendar (see [domains registry](../../domains/README.md)).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `time_key` | int | Business key, the time-of-day surrogate. |
| `second_of_day` | int | Seconds since midnight (0–86399). |
| `hour_of_day` | int | Hour (0–23). |
| `minute_of_hour` | int | Minute (0–59). |
| `second_of_minute` | int | Second (0–59). |
| `am_pm` | string | AM or PM. |
| `shift` | string | Work shift the time falls in. |
| `sub_shift` | string | Finer sub-shift band. |
| `meal_time` | string | Meal period (breakfast, lunch, dinner), if any. |

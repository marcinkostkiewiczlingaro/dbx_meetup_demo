---
c4_level: 4
type: table_schema
database: gold
table: dim_promotion
component: components/pipeline/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_promotion

| module | component | table | pipeline |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | [gold](../../components/pipeline/gold.md) | gold.dim_promotion | ← [silver.dim_promotion](../../components/pipeline/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** Conformed promotion dimension, one row per promotion. A store-sales line may carry no promotion.

## Columns

| Column | Type | Meaning |
|---|---|---|
| `promo_key` | int | Business key, one per promotion. |
| `promo_id` | string | Natural promotion id. |
| `promo_name` | string | Promotion name. |
| `promo_purpose` | string | Promotion purpose. |
| `promo_cost` | decimal | Cost of the promotion. |
| `is_discount_active` | boolean | Whether the discount is active. |
| `channel_email` | boolean | Whether the promotion ran on email. |
| `channel_tv` | boolean | Whether the promotion ran on TV. |

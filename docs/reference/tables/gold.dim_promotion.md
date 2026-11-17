---
c4_level: 4
type: table_schema
database: gold
table: dim_promotion
domain: Retail Analytics/Shared Dimensions
object_type: Promotion
primary_key: promo_key
source_of_truth: ${source_schema}.promotion
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_promotion

| module | component | table | pipeline |
|---|---|---|---|
| [core](../../modules/core.md) | [gold](../../components/core/gold.md) | gold.dim_promotion | ← [silver.dim_promotion](../../components/core/silver.md) · → [gold.fct_store_sales](./gold.fct_store_sales.md) |

> **C4 Level 4 — Table.** The **Promotion** business object: a marketing campaign a store-sales line may be attributed to. Conformed promotion dimension, one row per promotion. A store-sales line may carry no promotion.

- **Primary key:** `promo_key`
- **Source of truth:** `${source_schema}.promotion`

## Columns

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `promo_key` | int | `p_promo_sk` | Business key, one per promotion. |
| `promo_id` | string | `p_promo_id` | Natural promotion id. |
| `promo_name` | string | `p_promo_name` | Promotion name. |
| `promo_purpose` | string | `p_purpose` | Promotion purpose. |
| `promo_cost` | decimal | `p_cost` | Cost of the promotion. |
| `is_discount_active` | boolean | `p_discount_active` | Whether the discount is active. |
| `channel_email` | boolean | `p_channel_email` | Whether the promotion ran on email. |
| `channel_tv` | boolean | `p_channel_tv` | Whether the promotion ran on TV. |

## Links

- **Applies to** many [`gold.fct_store_sales`](./gold.fct_store_sales.md) via `promo_key` (one promotion → many store-sales lines; optional, `promo_key` may be null).

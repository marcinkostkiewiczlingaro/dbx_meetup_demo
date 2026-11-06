# Object Type: Promotion

A marketing campaign a store-sales line may be attributed to.

- **Backed by:** `gold.dim_promotion`
- **Primary key:** `promo_key`
- **Source of truth:** `${source_schema}.promotion`

A store-sales line may carry no promotion, so the link from Promotion to Store-Sales Line is
optional.

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| promo_key | `promo_key` | `p_promo_sk` | Business key, one per promotion. |
| promo_id | `promo_id` | `p_promo_id` | Natural promotion id. |
| promo_name | `promo_name` | `p_promo_name` | Promotion name. |
| promo_purpose | `promo_purpose` | `p_purpose` | Promotion purpose. |
| promo_cost | `promo_cost` | `p_cost` | Cost of the promotion. |
| is_discount_active | `is_discount_active` | `p_discount_active` | Whether the discount is active. |
| channel_email | `channel_email` | `p_channel_email` | Whether the promotion ran on email. |
| channel_tv | `channel_tv` | `p_channel_tv` | Whether the promotion ran on TV. |

## Links

- Applies to many **Store-Sales Line** (`promo_key`). See `../link-types.md`.

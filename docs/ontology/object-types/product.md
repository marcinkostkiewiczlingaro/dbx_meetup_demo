# Object Type: Product

An item offered for sale in a store.

- **Backed by:** `gold.dim_item`
- **Primary key:** `product_key`
- **Source of truth:** `samples.tpcds_sf1.item`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| product_key | `product_key` | `i_item_sk` | Business key, one per product version. |
| product_id | `product_id` | `i_item_id` | Stable public identifier. |
| product_name | `product_name` | `i_product_name` | Display name. |
| brand | `brand` | `i_brand` | Brand label. |
| category | `category` | `i_category` | Top-level merchandise category. |
| product_class | `product_class` | `i_class` | Sub-category within a category. |
| list_price | `list_price` | `i_current_price` | Current list price. |

## Links

- Appears in many **Sales Transaction** (`product_key`). See `../link-types.md`.

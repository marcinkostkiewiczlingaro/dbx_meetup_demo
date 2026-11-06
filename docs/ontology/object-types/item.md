# Object Type: Item

A product offered for sale in a store.

- **Backed by:** `gold.dim_item`
- **Primary key:** `item_key`
- **Source of truth:** `${source_schema}.item` (current records only)

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| item_key | `item_key` | `i_item_sk` | Business key, one per item. |
| item_id | `item_id` | `i_item_id` | Natural item id. |
| item_name | `item_name` | `i_product_name` | Product name. |
| item_description | `item_description` | `i_item_desc` | Product description. |
| brand | `brand` | `i_brand` | Brand. |
| class | `class` | `i_class` | Class within the category. |
| category | `category` | `i_category` | Category. |
| manufacturer | `manufacturer` | `i_manufact` | Manufacturer. |
| current_price | `current_price` | `i_current_price` | Current list price. |
| wholesale_cost | `wholesale_cost` | `i_wholesale_cost` | Wholesale cost. |

## Links

- Is sold in many **Store-Sales Line** (`item_key`). See `../link-types.md`.

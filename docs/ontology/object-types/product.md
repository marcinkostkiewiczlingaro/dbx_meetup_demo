# Object Type: Product

A bakery item offered for sale.

- **Backed by:** `gold.dim_product` (derived from the fact)
- **Primary key:** `product_name`
- **Source of truth:** `samples.bakehouse.sales_transactions` (the `product` column)

The bakehouse sample has no product table. The product list is derived from the distinct
products actually sold, so `product_name` is the natural business key.

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| product_name | `product_name` | `product` | Product name and business key. |

Known products: Golden Gate Ginger, Austin Almond Biscotti, Pearly Pies, Tokyo Tidbits,
Outback Oatmeal, Orchard Oasis.

## Links

- Appears in many **Sales Transaction** (`product_name`). See `../link-types.md`.

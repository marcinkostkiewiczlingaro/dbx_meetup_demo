# Object Type: Store-Sales Line

One ticket line: a single item bought by a customer at a store on a day, optionally under a
promotion. This is the measurable event the metrics count.

- **Backed by:** `gold.fct_store_sales`
- **Grain:** one row per ticket line (`ticket_number` × `item_key`)
- **Source of truth:** `${source_schema}.store_sales`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| ticket_number | `ticket_number` | `ss_ticket_number` | Store-sales ticket; groups the lines of one store visit. |
| item_key | `item_key` | `ss_item_sk` | Item sold. |
| customer_key | `customer_key` | `ss_customer_sk` | Customer. |
| store_key | `store_key` | `ss_store_sk` | Store. |
| promo_key | `promo_key` | `ss_promo_sk` | Promotion (nullable). |
| date_key | `date_key` | `ss_sold_date_sk` | Sold-date surrogate. |
| sold_date | `sold_date` | `d_date` (via `date_dim`) | Calendar day of the sale. |
| quantity | `quantity` | `ss_quantity` | Units sold. |
| list_price | `list_price` | `ss_list_price` | List price per unit. |
| sales_price | `sales_price` | `ss_sales_price` | Sales price per unit. |
| wholesale_cost | `wholesale_cost` | `ss_wholesale_cost` | Wholesale cost per unit. |
| sales_amount | `sales_amount` | `ss_ext_sales_price` | Extended sales price — the line's net revenue. |
| discount_amount | `discount_amount` | `ss_ext_discount_amt` | Extended discount given. |
| net_paid | `net_paid` | `ss_net_paid` | Net amount paid. |
| net_profit | `net_profit` | `ss_net_profit` | Net profit on the line. |

## Links

- Made by one **Customer** (`customer_key`).
- For one **Item** (`item_key`).
- At one **Store** (`store_key`).
- Optionally under one **Promotion** (`promo_key`).
- On one calendar day (`date_key` / `sold_date`).

See `../link-types.md`.

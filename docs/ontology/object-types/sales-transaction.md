# Object Type: Sales Transaction

One sold line: a single product sold on a sales ticket at a store on a day. This is the
measurable event the metrics count.

- **Backed by:** `gold.fct_store_sales`
- **Grain:** one row per sold line (ticket + product)
- **Source of truth:** `samples.tpcds_sf1.store_sales`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| sales_ticket_number | `sales_ticket_number` | `ss_ticket_number` | Groups lines bought together (an order). |
| quantity | `quantity` | `ss_quantity` | Units sold on the line. |
| unit_sales_price | `unit_sales_price` | `ss_sales_price` | Price per unit sold. |
| gross_sales_amount | `gross_sales_amount` | `ss_ext_sales_price` | Line value before discount. |
| discount_amount | `discount_amount` | `ss_ext_discount_amt` | Discount on the line. |
| net_sales_amount | `net_sales_amount` | `ss_net_paid` | Amount the customer paid. |
| net_profit_amount | `net_profit_amount` | `ss_net_profit` | Profit on the line. |

## Links

- Made by one **Customer** (`customer_key`).
- For one **Product** (`product_key`).
- At one **Store** (`store_key`).
- On one calendar day (`date_key`).

See `../link-types.md`.

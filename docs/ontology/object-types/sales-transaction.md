# Object Type: Sales Transaction

One sale: a single product bought by a customer at a franchise on a day. This is the
measurable event the metrics count.

- **Backed by:** `gold.fct_sales`
- **Grain:** one row per transaction (a single product purchase)
- **Source of truth:** `samples.bakehouse.sales_transactions`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| sales_transaction_id | `sales_transaction_id` | `transactionID` | Business key, one per sale. |
| product_name | `product_name` | `product` | Product sold. |
| sold_date | `sold_date` | `dateTime` (cast to date) | Day of the sale. |
| payment_method | `payment_method` | `paymentMethod` | Card used: amex, mastercard, or visa. |
| quantity | `quantity` | `quantity` | Units sold. |
| unit_price | `unit_price` | `unitPrice` | Price per unit. |
| sales_amount | `sales_amount` | `totalPrice` | Revenue of the sale (quantity x unit price). |

## Links

- Made by one **Customer** (`customer_key`).
- For one **Product** (`product_name`).
- At one **Franchise** (`franchise_key`).
- On one calendar day (`sold_date`).

See `../link-types.md`.

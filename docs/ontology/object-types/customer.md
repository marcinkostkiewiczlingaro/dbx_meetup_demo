# Object Type: Customer

A person who buys products from a bakery.

- **Backed by:** `gold.dim_customer`
- **Primary key:** `customer_key`
- **Source of truth:** `samples.bakehouse.sales_customers`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| customer_key | `customer_key` | `customerID` | Business key, one per customer. |
| first_name | `first_name` | `first_name` | Given name. |
| last_name | `last_name` | `last_name` | Family name. |
| city | `city` | `city` | City of residence. |
| state | `state` | `state` | State or region. |
| country | `country` | `country` | Country. |
| continent | `continent` | `continent` | Continent. |
| gender | `gender` | `gender` | Reported gender. |

Note: `email_address` and `phone_number` stay in silver and are not published to gold.
`cardNumber` never leaves bronze.

## Links

- Makes many **Sales Transaction** (`customer_key`). See `../link-types.md`.

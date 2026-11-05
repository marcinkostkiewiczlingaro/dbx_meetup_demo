# Object Type: Customer

A person who buys products in a store.

- **Backed by:** `gold.dim_customer`
- **Primary key:** `customer_key`
- **Source of truth:** `samples.tpcds_sf1.customer`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| customer_key | `customer_key` | `c_customer_sk` | Business key, one per customer. |
| customer_id | `customer_id` | `c_customer_id` | Stable public identifier. |
| first_name | `first_name` | `c_first_name` | Given name. |
| last_name | `last_name` | `c_last_name` | Family name. |
| is_preferred_customer | `is_preferred_customer` | `c_preferred_cust_flag` | Loyalty flag. |
| birth_country | `birth_country` | `c_birth_country` | Country of birth. |

## Links

- Makes many **Sales Transaction** (`customer_key`). See `../link-types.md`.

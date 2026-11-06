# Object Type: Customer

A person who buys items from a store.

- **Backed by:** `gold.dim_customer`
- **Primary key:** `customer_key`
- **Source of truth:** `${source_schema}.customer` + `${source_schema}.customer_address`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| customer_key | `customer_key` | `c_customer_sk` | Business key, one per customer. |
| customer_id | `customer_id` | `c_customer_id` | Natural customer id. |
| first_name | `first_name` | `c_first_name` | Given name. |
| last_name | `last_name` | `c_last_name` | Family name. |
| birth_country | `birth_country` | `c_birth_country` | Country of birth. |
| is_preferred_customer | `is_preferred_customer` | `c_preferred_cust_flag` | Preferred-customer flag. |
| customer_city | `customer_city` | `ca_city` | City of the address. |
| customer_county | `customer_county` | `ca_county` | County of the address. |
| customer_state | `customer_state` | `ca_state` | State of the address. |
| customer_zip | `customer_zip` | `ca_zip` | ZIP of the address. |
| customer_country | `customer_country` | `ca_country` | Country of the address. |

Note: `email_address` stays in `silver.dim_customer` and is not published to gold
(governance).

## Links

- Makes many **Store-Sales Line** (`customer_key`). See `../link-types.md`.

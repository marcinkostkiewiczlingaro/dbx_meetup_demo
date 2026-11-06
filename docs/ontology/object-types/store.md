# Object Type: Store

A physical store where store sales happen.

- **Backed by:** `gold.dim_store`
- **Primary key:** `store_key`
- **Source of truth:** `${source_schema}.store` (current records only)

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| store_key | `store_key` | `s_store_sk` | Business key, one per store. |
| store_id | `store_id` | `s_store_id` | Natural store id. |
| store_name | `store_name` | `s_store_name` | Store name. |
| store_city | `store_city` | `s_city` | City of the store. |
| store_county | `store_county` | `s_county` | County of the store. |
| store_state | `store_state` | `s_state` | State of the store. |
| store_zip | `store_zip` | `s_zip` | ZIP of the store. |
| store_country | `store_country` | `s_country` | Country of the store. |
| store_market_id | `store_market_id` | `s_market_id` | Market the store belongs to. |
| store_company | `store_company` | `s_company_name` | Company name. |
| floor_space | `floor_space` | `s_floor_space` | Floor space. |
| number_employees | `number_employees` | `s_number_employees` | Number of employees. |

## Links

- Hosts many **Store-Sales Line** (`store_key`). See `../link-types.md`.

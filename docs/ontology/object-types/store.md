# Object Type: Store

A physical retail location where sales happen.

- **Backed by:** `gold.dim_store`
- **Primary key:** `store_key`
- **Source of truth:** `samples.tpcds_sf1.store`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| store_key | `store_key` | `s_store_sk` | Business key, one per store version. |
| store_id | `store_id` | `s_store_id` | Stable public identifier. |
| store_name | `store_name` | `s_store_name` | Display name. |
| city | `city` | `s_city` | City of the store. |
| state | `state` | `s_state` | State or region. |
| country | `country` | `s_country` | Country. |
| floor_space_sqft | `floor_space_sqft` | `s_floor_space` | Selling area in square feet. |

## Links

- Hosts many **Sales Transaction** (`store_key`). See `../link-types.md`.

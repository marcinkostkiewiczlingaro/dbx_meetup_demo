# Object Type: Franchise

A bakery store location where sales happen. Each franchise buys its ingredient from one
supplier.

- **Backed by:** `gold.dim_franchise`
- **Primary key:** `franchise_key`
- **Source of truth:** `samples.bakehouse.sales_franchises`

## Properties

| Property | Gold column | Source column | Meaning |
|---|---|---|---|
| franchise_key | `franchise_key` | `franchiseID` | Business key, one per franchise. |
| franchise_name | `franchise_name` | `name` | Display name. |
| city | `city` | `city` | City of the store. |
| district | `district` | `district` | District or area. |
| country | `country` | `country` | Country. |
| store_size | `store_size` | `size` | Store size band (S to XXL). |
| supplier_key | `supplier_key` | `supplierID` | Link to the supplier. |
| supplier_name | `supplier_name` | from `sales_suppliers.name` | Supplier name, joined in gold. |
| supplier_ingredient | `supplier_ingredient` | from `sales_suppliers.ingredient` | Ingredient supplied. |

## Links

- Hosts many **Sales Transaction** (`franchise_key`).
- Supplied by one **Supplier** (`supplier_key`). See `../link-types.md`.

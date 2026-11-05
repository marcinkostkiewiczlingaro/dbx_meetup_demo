# Object Type: Supplier

A business that supplies one ingredient to bakery franchises.

- **Backed by:** joined into `gold.dim_franchise` (no standalone gold table)
- **Primary key:** `supplier_key`
- **Source of truth:** `samples.bakehouse.sales_suppliers`

The supplier has no metrics of its own, so gold folds it into the franchise dimension.
The silver layer keeps it as `silver.dim_supplier` for lineage.

## Properties

| Property | Silver column | Source column | Meaning |
|---|---|---|---|
| supplier_key | `supplier_key` | `supplierID` | Business key, one per supplier. |
| supplier_name | `supplier_name` | `name` | Display name. |
| ingredient | `ingredient` | `ingredient` | Ingredient supplied. |
| city | `city` | `city` | Supplier city. |
| district | `district` | `district` | Supplier district. |
| continent | `continent` | `continent` | Supplier continent. |
| is_approved | `is_approved` | `approved` | Whether the supplier is approved. |

## Links

- Supplies many **Franchise** (`supplier_key`). See `../link-types.md`.

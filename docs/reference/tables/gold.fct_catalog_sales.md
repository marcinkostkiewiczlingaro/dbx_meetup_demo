---
c4_level: 4
type: table_schema
database: gold
table: fct_catalog_sales
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_catalog_sales

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.fct_catalog_sales | ← [silver.fct_catalog_sales](../../components/catalog_sales/silver.md) · → [gold.catalog_sales_enriched](./gold.catalog_sales_enriched.md) |

> **C4 Level 4 — Table.** The conformed catalog-sales fact. Grain: one catalog-sales order line (`order_number` × `item_key`).

## Columns

Keys:

| Column | Type | Meaning |
|---|---|---|
| `order_number` | long | Catalog-sales order; groups the lines of one order. |
| `item_key` | int | Item sold (→ `gold.dim_item`). |
| `customer_key` | int | Customer (→ `gold.dim_customer`). |
| `call_center_key` | int | Call center that took the order (→ `gold.dim_call_center`); nullable. |
| `catalog_page_key` | int | Catalog page ordered from (→ `gold.dim_catalog_page`); nullable. |
| `ship_mode_key` | int | Shipping method (→ `gold.dim_ship_mode`); nullable. |
| `promo_key` | int | Promotion (→ `gold.dim_promotion`); nullable. |
| `date_key` | int | Sold-date surrogate (→ `gold.dim_date`). |
| `sold_date` | date | Calendar day of the sale. |

Measures:

| Column | Type | Meaning |
|---|---|---|
| `quantity` | int | Units sold on the line. |
| `list_price` | decimal | List price per unit. |
| `sales_price` | decimal | Actual sales price per unit. |
| `wholesale_cost` | decimal | Wholesale cost per unit. |
| `sales_amount` | decimal | Extended sales price — the line's net revenue. |
| `discount_amount` | decimal | Extended discount given on the line. |
| `net_paid` | decimal | Net amount paid. |
| `net_profit` | decimal | Net profit on the line. |

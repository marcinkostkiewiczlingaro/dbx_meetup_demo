---
c4_level: 4
type: table_schema
database: gold
table: fct_catalog_sales
domain: Retail Analytics/Sales
object_type: Catalog-Sales Line
primary_key: order_number + item_key
source_of_truth: ${source_schema}.catalog_sales
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_catalog_sales

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.fct_catalog_sales | ← [silver.fct_catalog_sales](../../components/catalog_sales/silver.md) · → [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Table.** The **Catalog-Sales Line** business object: one item a customer buys on a catalog order on a day, optionally under a promotion — the measurable event the metrics count. Grain: one catalog-sales order line (`order_number` × `item_key`).

- **Primary key:** `order_number` + `item_key`
- **Source of truth:** `${source_schema}.catalog_sales`

## Columns

Keys:

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `order_number` | long | `cs_order_number` | Catalog-sales order; groups the lines of one order. |
| `item_key` | int | `cs_item_sk` | Item sold (→ `gold.dim_item`). |
| `customer_key` | int | `cs_bill_customer_sk` | Billed customer (→ `gold.dim_customer`). |
| `call_center_key` | int | `cs_call_center_sk` | Call center that took the order (→ `gold.dim_call_center`); nullable. |
| `catalog_page_key` | int | `cs_catalog_page_sk` | Catalog page ordered from (→ `gold.dim_catalog_page`); nullable. |
| `ship_mode_key` | int | `cs_ship_mode_sk` | Shipping method (→ `gold.dim_ship_mode`); nullable. |
| `promo_key` | int | `cs_promo_sk` | Promotion (→ `gold.dim_promotion`); nullable. |
| `date_key` | int | `cs_sold_date_sk` | Sold-date surrogate (→ `gold.dim_date`). |
| `sold_date` | date | `d_date` (via `date_dim`) | Calendar day of the sale. |

Measures:

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `quantity` | int | `cs_quantity` | Units sold on the line. |
| `list_price` | decimal | `cs_list_price` | List price per unit. |
| `sales_price` | decimal | `cs_sales_price` | Actual sales price per unit. |
| `wholesale_cost` | decimal | `cs_wholesale_cost` | Wholesale cost per unit. |
| `sales_amount` | decimal | `cs_ext_sales_price` | Extended sales price — the line's net revenue. |
| `discount_amount` | decimal | `cs_ext_discount_amt` | Extended discount given on the line. |
| `net_paid` | decimal | `cs_net_paid` | Net amount paid. |
| `net_profit` | decimal | `cs_net_profit` | Net profit on the line. |

## Links

The fact sits at the center of the catalog-sales star. Each key is a foreign key to one
dimension; the business verb names the relationship.

| Link | To dimension | Key | Cardinality |
|---|---|---|---|
| made by | [`gold.dim_customer`](./gold.dim_customer.md) | `customer_key` | many lines → one customer |
| for | [`gold.dim_item`](./gold.dim_item.md) | `item_key` | many lines → one item |
| handled by | [`gold.dim_call_center`](./gold.dim_call_center.md) | `call_center_key` | many lines → one call center (optional) |
| from | [`gold.dim_catalog_page`](./gold.dim_catalog_page.md) | `catalog_page_key` | many lines → one catalog page (optional) |
| shipped by | [`gold.dim_ship_mode`](./gold.dim_ship_mode.md) | `ship_mode_key` | many lines → one ship mode (optional) |
| under | [`gold.dim_promotion`](./gold.dim_promotion.md) | `promo_key` | many lines → one promotion (optional) |
| on | [`gold.dim_date`](./gold.dim_date.md) | `date_key` | many lines → one calendar day |

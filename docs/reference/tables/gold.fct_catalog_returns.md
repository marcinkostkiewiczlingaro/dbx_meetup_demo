---
c4_level: 4
type: table_schema
database: gold
table: fct_catalog_returns
domain: Retail Analytics/Returns
object_type: Catalog-Return Line
primary_key: order_number + item_key
source_of_truth: ${source_schema}.catalog_returns
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_catalog_returns

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.fct_catalog_returns | ← [silver.fct_catalog_returns](../../components/catalog_sales/silver.md) |

> **C4 Level 4 — Table.** The **Catalog-Return Line** business object: one item a customer returns from a catalog order on a day — the measurable loss the returns metrics count. Grain: one catalog-return line (`order_number` × `item_key`).

- **Primary key:** `order_number` + `item_key`
- **Source of truth:** `${source_schema}.catalog_returns`

## Columns

Keys:

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `order_number` | long | `cr_order_number` | Catalog-return order; groups the return lines of one order. |
| `item_key` | int | `cr_item_sk` | Item returned (→ `gold.dim_item`). |
| `customer_key` | int | `cr_returning_customer_sk` | Returning customer (→ `gold.dim_customer`). |
| `call_center_key` | int | `cr_call_center_sk` | Call center that handled the return (→ `gold.dim_call_center`); nullable. |
| `catalog_page_key` | int | `cr_catalog_page_sk` | Catalog page ordered from (→ `gold.dim_catalog_page`); nullable. |
| `ship_mode_key` | int | `cr_ship_mode_sk` | Shipping method (→ `gold.dim_ship_mode`); nullable. |
| `date_key` | int | `cr_returned_date_sk` | Returned-date surrogate (→ `gold.dim_date`). |
| `returned_date` | date | `d_date` (via `date_dim`) | Calendar day of the return. |

Measures:

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `return_quantity` | int | `cr_return_quantity` | Units returned on the line. |
| `return_amount` | decimal | `cr_return_amount` | Extended amount returned. |
| `return_tax` | decimal | `cr_return_tax` | Tax returned. |
| `return_fee` | decimal | `cr_fee` | Return fee charged. |
| `net_loss` | decimal | `cr_net_loss` | Net loss on the return. |

## Links

The fact sits at the center of the catalog-returns star. Each key is a foreign key to one
dimension; the business verb names the relationship.

| Link | To dimension | Key | Cardinality |
|---|---|---|---|
| returned by | [`gold.dim_customer`](./gold.dim_customer.md) | `customer_key` | many lines → one customer |
| for | [`gold.dim_item`](./gold.dim_item.md) | `item_key` | many lines → one item |
| handled by | [`gold.dim_call_center`](./gold.dim_call_center.md) | `call_center_key` | many lines → one call center (optional) |
| from | [`gold.dim_catalog_page`](./gold.dim_catalog_page.md) | `catalog_page_key` | many lines → one catalog page (optional) |
| shipped by | [`gold.dim_ship_mode`](./gold.dim_ship_mode.md) | `ship_mode_key` | many lines → one ship mode (optional) |
| on | [`gold.dim_date`](./gold.dim_date.md) | `date_key` | many lines → one calendar day |

---
c4_level: 4
type: table_schema
database: gold
table: fct_catalog_returns
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_catalog_returns

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.fct_catalog_returns | ← [silver.fct_catalog_returns](../../components/catalog_sales/silver.md) |

> **C4 Level 4 — Table.** The conformed catalog-returns fact. Grain: one catalog-return line (`order_number` × `item_key`).

## Columns

Keys:

| Column | Type | Meaning |
|---|---|---|
| `order_number` | long | Catalog-return order; groups the return lines of one order. |
| `item_key` | int | Item returned (→ `gold.dim_item`). |
| `customer_key` | int | Returning customer (→ `gold.dim_customer`). |
| `call_center_key` | int | Call center that handled the return (→ `gold.dim_call_center`); nullable. |
| `catalog_page_key` | int | Catalog page ordered from (→ `gold.dim_catalog_page`); nullable. |
| `ship_mode_key` | int | Shipping method (→ `gold.dim_ship_mode`); nullable. |
| `date_key` | int | Returned-date surrogate (→ `gold.dim_date`). |
| `returned_date` | date | Calendar day of the return. |

Measures:

| Column | Type | Meaning |
|---|---|---|
| `return_quantity` | int | Units returned on the line. |
| `return_amount` | decimal | Extended amount returned. |
| `return_tax` | decimal | Tax returned. |
| `return_fee` | decimal | Return fee charged. |
| `net_loss` | decimal | Net loss on the return. |

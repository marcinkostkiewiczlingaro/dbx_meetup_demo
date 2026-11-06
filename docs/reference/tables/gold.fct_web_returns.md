---
c4_level: 4
type: table_schema
database: gold
table: fct_web_returns
component: components/web_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_web_returns

| module | component | table | pipeline |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | [gold](../../components/web_sales/gold.md) | gold.fct_web_returns | ← [silver.fct_web_returns](../../components/web_sales/silver.md) |

> **C4 Level 4 — Table.** The conformed web-returns fact. Grain: one web-return line (`order_number` × `item_key`).

## Columns

Keys:

| Column | Type | Meaning |
|---|---|---|
| `order_number` | long | Web-return order; groups the return lines of one order. |
| `item_key` | int | Item returned (→ `gold.dim_item`). |
| `customer_key` | int | Returning customer (→ `gold.dim_customer`). |
| `web_page_key` | int | Web page ordered from (→ `gold.dim_web_page`); nullable. |
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

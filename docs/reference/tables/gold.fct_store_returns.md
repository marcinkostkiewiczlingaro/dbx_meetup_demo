---
c4_level: 4
type: table_schema
database: gold
table: fct_store_returns
component: components/store_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_store_returns

| module | component | table | pipeline |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [gold](../../components/store_sales/gold.md) | gold.fct_store_returns | ← [silver.fct_store_returns](../../components/store_sales/silver.md) |

> **C4 Level 4 — Table.** The conformed store-returns fact. Grain: one store-return line (`ticket_number` × `item_key`).

## Columns

Keys:

| Column | Type | Meaning |
|---|---|---|
| `ticket_number` | long | Store-return ticket; groups the return lines of one visit. |
| `item_key` | int | Item returned (→ `gold.dim_item`). |
| `customer_key` | int | Returning customer (→ `gold.dim_customer`). |
| `store_key` | int | Store (→ `gold.dim_store`). |
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

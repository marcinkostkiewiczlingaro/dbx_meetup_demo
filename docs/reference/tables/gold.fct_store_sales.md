---
c4_level: 4
type: table_schema
database: gold
table: fct_store_sales
component: components/pipeline/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_store_sales

| module | component | table | pipeline |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | [gold](../../components/pipeline/gold.md) | gold.fct_store_sales | ← [silver.fct_store_sales](../../components/pipeline/silver.md) · → [gold.store_sales_enriched](./gold.store_sales_enriched.md) |

> **C4 Level 4 — Table.** The conformed store-sales fact. Grain: one store-sales ticket line (`ticket_number` × `item_key`).

## Columns

Keys:

| Column | Type | Meaning |
|---|---|---|
| `ticket_number` | long | Store-sales ticket; groups the lines of one store visit. |
| `item_key` | int | Item sold (→ `gold.dim_item`). |
| `customer_key` | int | Customer (→ `gold.dim_customer`). |
| `store_key` | int | Store (→ `gold.dim_store`). |
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

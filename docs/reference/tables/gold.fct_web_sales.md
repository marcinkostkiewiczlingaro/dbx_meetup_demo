---
c4_level: 4
type: table_schema
database: gold
table: fct_web_sales
component: components/web_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_web_sales

| module | component | table | pipeline |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | [gold](../../components/web_sales/gold.md) | gold.fct_web_sales | ← [silver.fct_web_sales](../../components/web_sales/silver.md) · → [gold.web_sales_enriched](./gold.web_sales_enriched.md) |

> **C4 Level 4 — Table.** The conformed web-sales fact. Grain: one web-sales order line (`order_number` × `item_key`).

## Columns

Keys:

| Column | Type | Meaning |
|---|---|---|
| `order_number` | long | Web-sales order; groups the lines of one order. |
| `item_key` | int | Item sold (→ `gold.dim_item`). |
| `customer_key` | int | Customer (→ `gold.dim_customer`). |
| `web_site_key` | int | Web site the order came through (→ `gold.dim_web_site`); nullable. |
| `web_page_key` | int | Web page ordered from (→ `gold.dim_web_page`); nullable. |
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

---
c4_level: 4
type: table_schema
database: gold
table: fct_store_sales
domain: Retail Analytics/Sales
object_type: Store-Sales Line
primary_key: ticket_number + item_key
source_of_truth: ${source_schema}.store_sales
component: components/store_sales/gold.md
partition_columns: []
data_layer: Gold (star schema fact)
---
# gold.fct_store_sales

| module | component | table | pipeline |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [gold](../../components/store_sales/gold.md) | gold.fct_store_sales | ← [silver.fct_store_sales](../../components/store_sales/silver.md) · → [store_sales_metrics](../metrics_views/store_sales_metrics.md) |

> **C4 Level 4 — Table.** The **Store-Sales Line** business object: one item bought by a customer at a store on a day, optionally under a promotion — the measurable event the metrics count. Grain: one store-sales ticket line (`ticket_number` × `item_key`).

- **Grain:** one row per ticket line (`ticket_number` × `item_key`)
- **Source of truth:** `${source_schema}.store_sales`

## Columns

Keys:

| Column          | Type | Source column             | Meaning                                                  |
| --------------- | ---- | ------------------------- | -------------------------------------------------------- |
| `ticket_number` | long | `ss_ticket_number`        | Store-sales ticket; groups the lines of one store visit. |
| `item_key`      | int  | `ss_item_sk`              | Item sold (→ `gold.dim_item`).                           |
| `customer_key`  | int  | `ss_customer_sk`          | Customer (→ `gold.dim_customer`).                        |
| `store_key`     | int  | `ss_store_sk`             | Store (→ `gold.dim_store`).                              |
| `promo_key`     | int  | `ss_promo_sk`             | Promotion (→ `gold.dim_promotion`); nullable.            |
| `date_key`      | int  | `ss_sold_date_sk`         | Sold-date surrogate (→ `gold.dim_date`).                 |
| `sold_date`     | date | `d_date` (via `date_dim`) | Calendar day of the sale.                                |

Measures:

| Column | Type | Source column | Meaning |
|---|---|---|---|
| `quantity` | int | `ss_quantity` | Units sold on the line. |
| `list_price` | decimal | `ss_list_price` | List price per unit. |
| `sales_price` | decimal | `ss_sales_price` | Actual sales price per unit. |
| `wholesale_cost` | decimal | `ss_wholesale_cost` | Wholesale cost per unit. |
| `sales_amount` | decimal | `ss_ext_sales_price` | Extended sales price — the line's net revenue. |
| `discount_amount` | decimal | `ss_ext_discount_amt` | Extended discount given on the line. |
| `net_paid` | decimal | `ss_net_paid` | Net amount paid. |
| `net_profit` | decimal | `ss_net_profit` | Net profit on the line. |

## Links

The fact sits at the center of the store star schema. Each key is a foreign key to one
dimension; the business verb names the relationship.

| Link    | To dimension                                    | Key            | Cardinality                           |
| ------- | ----------------------------------------------- | -------------- | ------------------------------------- |
| made by | [`gold.dim_customer`](./gold.dim_customer.md)   | `customer_key` | many lines → one customer             |
| for     | [`gold.dim_item`](./gold.dim_item.md)           | `item_key`     | many lines → one item                 |
| at      | [`gold.dim_store`](./gold.dim_store.md)         | `store_key`    | many lines → one store                |
| under   | [`gold.dim_promotion`](./gold.dim_promotion.md) | `promo_key`    | many lines → one promotion (optional) |
| on      | [`gold.dim_date`](./gold.dim_date.md)           | `date_key`     | many lines → one calendar day         |

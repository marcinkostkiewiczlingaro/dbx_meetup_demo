---
c4_level: 4
type: table_schema
database: gold
table: store_sales_enriched
component: components/store_sales/gold.md
partition_columns: []
data_layer: Gold (consumption)
---
# gold.store_sales_enriched

| module | component | table | pipeline |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [gold](../../components/store_sales/gold.md) | gold.store_sales_enriched | ← [gold.fct_store_sales](./gold.fct_store_sales.md) · → [store_sales_metrics](../metrics_views/store_sales_metrics.md) |

> **C4 Level 4 — Table.** The store-sales fact widened with descriptive dimension columns, so the Metric View and Genie read one table with no joins.

## Columns

Keys and time:

| Column | Type | Meaning |
|---|---|---|
| `ticket_number` | long | Store-sales ticket; count distinct for store visits. |
| `date_key` | int | Sold-date surrogate. |
| `sold_date` | date | Calendar day of the sale. |
| `calendar_year` | int | Year of the sale. |
| `month_name` | string | Month of the sale. |
| `quarter_of_year` | int | Quarter of the sale. |

Item:

| Column | Type | Meaning |
|---|---|---|
| `item_key` | int | Item sold. |
| `item_name` | string | Product name. |
| `brand` | string | Brand. |
| `class` | string | Class. |
| `category` | string | Category. |
| `manufacturer` | string | Manufacturer. |

Customer and store:

| Column | Type | Meaning |
|---|---|---|
| `customer_key` | int | Customer. |
| `customer_state` | string | State of the customer. |
| `customer_country` | string | Country of the customer. |
| `store_key` | int | Store. |
| `store_name` | string | Store name. |
| `store_state` | string | State of the store. |
| `store_country` | string | Country of the store. |
| `store_market_id` | int | Market the store belongs to. |

Promotion and measures:

| Column | Type | Meaning |
|---|---|---|
| `promo_key` | int | Promotion; nullable. |
| `promo_name` | string | Promotion name. |
| `promo_purpose` | string | Promotion purpose. |
| `quantity` | int | Units sold. |
| `list_price` | decimal | List price per unit. |
| `sales_price` | decimal | Sales price per unit. |
| `wholesale_cost` | decimal | Wholesale cost per unit. |
| `sales_amount` | decimal | Extended sales price — net revenue. |
| `discount_amount` | decimal | Extended discount. |
| `net_paid` | decimal | Net amount paid. |
| `net_profit` | decimal | Net profit. |

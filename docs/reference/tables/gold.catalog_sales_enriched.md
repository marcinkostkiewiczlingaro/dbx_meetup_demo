---
c4_level: 4
type: table_schema
database: gold
table: catalog_sales_enriched
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (consumption)
---
# gold.catalog_sales_enriched

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.catalog_sales_enriched | ← [gold.fct_catalog_sales](./gold.fct_catalog_sales.md) · → [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Table.** The catalog-sales fact widened with descriptive dimension columns, so the Metric View and Genie read one table with no joins.

## Columns

Keys and time:

| Column | Type | Meaning |
|---|---|---|
| `order_number` | long | Catalog-sales order; count distinct for orders. |
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

Customer and catalog dims:

| Column | Type | Meaning |
|---|---|---|
| `customer_key` | int | Customer. |
| `customer_state` | string | State of the customer. |
| `customer_country` | string | Country of the customer. |
| `call_center_key` | int | Call center that took the order. |
| `call_center_name` | string | Call-center name. |
| `call_center_class` | string | Class of the call center. |
| `call_center_state` | string | State of the call center. |
| `call_center_country` | string | Country of the call center. |
| `catalog_page_key` | int | Catalog page ordered from. |
| `catalog_department` | string | Department of the catalog page. |
| `page_type` | string | Type of the catalog page. |
| `ship_mode_key` | int | Shipping method. |
| `ship_mode_type` | string | Type of shipping method. |
| `carrier` | string | Carrier that ships the order. |

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

---
c4_level: 4
type: metric_view
metric_view: store_sales_metrics
source: workspace.gold.store_sales_enriched
created_as: workspace.gold.store_sales_metrics
component: components/store_sales/metrics.md
---
# Metric View — store_sales_metrics

| module | component | metric view | source |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [metrics](../../components/store_sales/metrics.md) | `workspace.gold.store_sales_metrics` | [gold.store_sales_enriched](../tables/gold.store_sales_enriched.md) |

> **C4 Level 4 — Metric View.** The governed definition of the store-sales metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the wide `gold.store_sales_enriched` table, so it needs no joins
(Free Edition rejects `using`-key joins). Every measure and dimension name here is the one
business term — the ontology, the semantic component, the Genie space, and the dashboard
tiles all spell it the same way.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Net Sales | `SUM(sales_amount)` | Total net revenue, the extended sales price of each line. |
| Quantity Sold | `SUM(quantity)` | Total units sold. |
| Ticket Count | `COUNT(DISTINCT ticket_number)` | Number of distinct store-sales tickets (store visits). |
| Line Count | `COUNT(1)` | Number of store-sales lines. |
| Average Ticket Value | `SUM(sales_amount) / COUNT(DISTINCT ticket_number)` | Net sales divided by ticket count. |
| Net Profit | `SUM(net_profit)` | Total net profit across lines. |
| Discount Amount | `SUM(discount_amount)` | Total extended discount given. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Sold Date | `sold_date` | Calendar day of the sale. |
| Calendar Year | `calendar_year` | Year of the sale. |
| Month Name | `month_name` | Month of the sale. |
| Item | `item_name` | Product sold. |
| Brand | `brand` | Brand of the item. |
| Class | `class` | Class of the item. |
| Category | `category` | Category of the item. |
| Store | `store_name` | Store where the sale happened. |
| Store State | `store_state` | State of the store. |
| Store Country | `store_country` | Country of the store. |
| Customer State | `customer_state` | State of the customer. |
| Promotion | `promo_name` | Promotion the line is attributed to. |

## Definition

```yaml
version: 0.1

source: workspace.gold.store_sales_enriched

dimensions:
  - name: Sold Date
    expr: sold_date
  - name: Calendar Year
    expr: calendar_year
  - name: Month Name
    expr: month_name
  - name: Item
    expr: item_name
  - name: Brand
    expr: brand
  - name: Class
    expr: class
  - name: Category
    expr: category
  - name: Store
    expr: store_name
  - name: Store State
    expr: store_state
  - name: Store Country
    expr: store_country
  - name: Customer State
    expr: customer_state
  - name: Promotion
    expr: promo_name

measures:
  - name: Net Sales
    expr: SUM(sales_amount)
  - name: Quantity Sold
    expr: SUM(quantity)
  - name: Ticket Count
    expr: COUNT(DISTINCT ticket_number)
  - name: Line Count
    expr: COUNT(1)
  - name: Average Ticket Value
    expr: SUM(sales_amount) / COUNT(DISTINCT ticket_number)
  - name: Net Profit
    expr: SUM(net_profit)
  - name: Discount Amount
    expr: SUM(discount_amount)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.store_sales_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Category`, MEASURE(`Net Sales`), MEASURE(`Ticket Count`)
FROM workspace.gold.store_sales_metrics
GROUP BY `Category`
ORDER BY 2 DESC;
```

---
c4_level: 4
type: metric_view
metric_view: web_sales_metrics
source: workspace.gold.web_sales_enriched
created_as: workspace.gold.web_sales_metrics
component: components/web_sales/metrics.md
---
# Metric View — web_sales_metrics

| module | component | metric view | source |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | [metrics](../../components/web_sales/metrics.md) | `workspace.gold.web_sales_metrics` | [gold.web_sales_enriched](../tables/gold.web_sales_enriched.md) |

> **C4 Level 4 — Metric View.** The governed definition of the web-sales metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the wide `gold.web_sales_enriched` table, so it needs no joins
(Free Edition rejects `using`-key joins). `Net Sales` and `Quantity Sold` carry the exact
same name and expression as the store-sales and catalog-sales metric views — one name for
one thing. The transaction count is `Order Count` here, the same name and expression as the
catalog-sales view (catalog and web sell by order); the store view counts tickets instead.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Net Sales | `SUM(sales_amount)` | Total net revenue, the extended sales price of each line. |
| Quantity Sold | `SUM(quantity)` | Total units sold. |
| Order Count | `COUNT(DISTINCT order_number)` | Number of distinct web-sales orders. |
| Line Count | `COUNT(1)` | Number of web-sales lines. |
| Average Order Value | `SUM(sales_amount) / COUNT(DISTINCT order_number)` | Net sales divided by order count. |
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
| Web Site | `web_site_name` | Web site the order came through. |
| Web Site State | `web_site_state` | State of the web site. |
| Web Page Type | `page_type` | Type of the web page ordered from. |
| Customer State | `customer_state` | State of the customer. |
| Promotion | `promo_name` | Promotion the line is attributed to. |

## Definition

```yaml
version: 0.1

source: workspace.gold.web_sales_enriched

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
  - name: Web Site
    expr: web_site_name
  - name: Web Site State
    expr: web_site_state
  - name: Web Page Type
    expr: page_type
  - name: Customer State
    expr: customer_state
  - name: Promotion
    expr: promo_name

measures:
  - name: Net Sales
    expr: SUM(sales_amount)
  - name: Quantity Sold
    expr: SUM(quantity)
  - name: Order Count
    expr: COUNT(DISTINCT order_number)
  - name: Line Count
    expr: COUNT(1)
  - name: Average Order Value
    expr: SUM(sales_amount) / COUNT(DISTINCT order_number)
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
CREATE OR REPLACE VIEW workspace.gold.web_sales_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Category`, MEASURE(`Net Sales`), MEASURE(`Order Count`)
FROM workspace.gold.web_sales_metrics
GROUP BY `Category`
ORDER BY 2 DESC;
```

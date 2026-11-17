---
c4_level: 4
type: page
page: Sales Quantity
page_id: a0a02ae2-00e1-4e67-8114-dc0ec295a560
domain: Retail Analytics
defines: "`Sales Quantity` measure"
metric_views: [store_sales_metrics, web_sales_metrics, catalog_sales_metrics]
synonyms: [quantity sold, units sold]
state: PUBLISHED
---
# Sales Quantity

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Sales Quantity | `Sales Quantity` measure | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Sales Quantity** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Unit volume of merchandise sold: SUM(quantity) per line in the gold store, web, and catalog sales metric views.

## Definition
Unit volume of merchandise sold: SUM(quantity) per sales line, exposed as the `Sales Quantity` measure in the gold store, web, and catalog sales metric views.

## Business use
Demand volume analysis complementing value measures such as Gross Sales; the denominator of unit-based Return Rate.

## Examples
SELECT `Brand`, MEASURE(`Sales Quantity`) FROM workspace.gold.web_sales_metrics GROUP BY ALL

## Synonyms

quantity sold, units sold

## Metric Views

- [store_sales_metrics](../metrics_views/store_sales_metrics.md)
- [web_sales_metrics](../metrics_views/web_sales_metrics.md)
- [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md)

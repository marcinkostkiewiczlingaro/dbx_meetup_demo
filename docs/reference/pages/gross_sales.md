---
c4_level: 4
type: page
page: Gross Sales
page_id: 690c0db0-eada-4ff3-b06b-397eb45de295
domain: Retail Analytics
defines: `Gross Sales` measure
metric_views: [store_sales_metrics, web_sales_metrics, catalog_sales_metrics]
synonyms: [gross revenue, top-line sales]
state: PUBLISHED
---
# Gross Sales

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Gross Sales | `Gross Sales` measure | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Gross Sales** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Top-line revenue before any discounts: sales_price × quantity summed over sales lines in the gold sales metric views.

## Definition
Top-line revenue before any discounts: the per-line product of unit sales price and quantity, aggregated as SUM(sales_price * quantity) and exposed as the `Gross Sales` measure in the gold store, web, and catalog sales metric views.

## Business use
Starting point for channel revenue analysis. Compare with Net Sales and Net Paid to isolate the effect of promotional discounts and coupons.

## Examples
SELECT `Store Name`, MEASURE(`Gross Sales`) FROM workspace.gold.store_sales_metrics GROUP BY ALL

## Synonyms

gross revenue, top-line sales

## Metric Views

- [store_sales_metrics](../metrics_views/store_sales_metrics.md)
- [web_sales_metrics](../metrics_views/web_sales_metrics.md)
- [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md)

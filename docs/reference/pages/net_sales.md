---
c4_level: 4
type: page
page: Net Sales
page_id: c1eea050-a10d-405e-9540-39ca03e90596
domain: Retail Analytics
defines: "`Extended Sales Price` measure"
metric_views: [store_sales_metrics, web_sales_metrics, catalog_sales_metrics]
synonyms: [extended sales price, net revenue]
state: PUBLISHED
---
# Net Sales

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Net Sales | `Extended Sales Price` measure | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Net Sales** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Revenue after promotional discounts, before coupons: SUM(sales_amount) per line, exposed as the Extended Sales Price measure.

## Definition
Revenue after promotional discounts but before coupon redemption: the line-level extended sales price, aggregated as SUM(sales_amount) and exposed as the `Extended Sales Price` measure in the gold sales metric views.

## Business use
The standard net revenue basis for reporting. sales_price alone is a unit price and must never substitute for the line-level extended amount.

## Examples
SELECT `Brand`, MEASURE(`Extended Sales Price`) AS net_sales FROM workspace.gold.web_sales_metrics GROUP BY ALL

## Synonyms

extended sales price, net revenue


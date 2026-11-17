---
c4_level: 4
type: page
page: Net Paid
page_id: d63a9719-63d2-4d77-941f-ea0adbb6a2a2
domain: Retail Analytics
defines: `Net Paid` measure
metric_views: [store_sales_metrics, web_sales_metrics, catalog_sales_metrics]
synonyms: [paid amount]
state: PUBLISHED
---
# Net Paid

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Net Paid | `Net Paid` measure | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Net Paid** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Cash actually collected per sales line after discounts and coupons: SUM(net_paid) in the gold sales metric views.

## Definition
The cash value actually paid for a sales line after both promotional discounts and coupon redemption, aggregated as SUM(net_paid) in the gold store, web, and catalog sales metric views.

## Business use
Realized payments measure. The gap between Net Sales and Net Paid quantifies coupon impact on collected revenue.

## Examples
SELECT `Promotion Name`, MEASURE(`Net Paid`) FROM workspace.gold.catalog_sales_metrics GROUP BY ALL

## Synonyms

paid amount

## Metric Views

- [store_sales_metrics](../metrics_views/store_sales_metrics.md)
- [web_sales_metrics](../metrics_views/web_sales_metrics.md)
- [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md)

---
c4_level: 4
type: page
page: Return Rate
page_id: 4b8526c1-bb3c-4b2b-8ab5-ee21036d8e91
domain: Retail Analytics
defines: "derived ratio (Returned Quantity ÷ Sales Quantity, or Return Amount ÷ Gross Sales)"
metric_views: [store_sales_metrics, web_sales_metrics, catalog_sales_metrics, store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [return percentage, return ratio, returns rate]
state: PUBLISHED
---
# Return Rate

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Return Rate | derived ratio (Returned Quantity ÷ Sales Quantity, or Return Amount ÷ Gross Sales) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) · [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Return Rate** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Returned units or value as a share of sales within a channel: Returned Quantity ÷ Sales Quantity, or Return Amount ÷ Gross Sales.

## Definition
Share of sold merchandise that comes back, computed within a single channel: unit-based Return Rate = Returned Quantity ÷ Sales Quantity, or value-based Return Rate = Return Amount ÷ Gross Sales, using the gold sales and returns metric views of the same channel.

## Business use
Frequency of returns by channel, brand, or category. Combine with Net Loss to weigh frequency against cost.

## Examples
Unit Return Rate by brand from workspace.gold.store_sales_metrics and workspace.gold.store_returns_metrics.

## Synonyms

return percentage, return ratio, returns rate


---
c4_level: 4
type: page
page: Net Profit
page_id: e501f7c1-327e-4532-96ca-d06ec978d63f
domain: Retail Analytics
defines: "`Net Profit` measure"
metric_views: [store_sales_metrics, web_sales_metrics, catalog_sales_metrics]
synonyms: [profit, sales margin]
state: PUBLISHED
---
# Net Profit

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Net Profit | `Net Profit` measure | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Net Profit** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Margin earned on sales lines: SUM(net_profit) in the gold store, web, and catalog sales metric views.

## Definition
Margin recorded on each sales line after cost and charges, aggregated as SUM(net_profit) in the gold store, web, and catalog sales metric views.

## Business use
Profitability analysis by channel, brand, category, store, or promotion.

## Examples
SELECT `Category`, MEASURE(`Net Profit`) FROM workspace.gold.store_sales_metrics GROUP BY ALL

## Synonyms

profit, sales margin

## Metric Views

- [store_sales_metrics](../metrics_views/store_sales_metrics.md)
- [web_sales_metrics](../metrics_views/web_sales_metrics.md)
- [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md)

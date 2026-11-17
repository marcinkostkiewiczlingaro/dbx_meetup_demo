---
c4_level: 4
type: page
page: Returned Quantity
page_id: 480f4db3-d4bb-4a63-a3db-1176bfdf5131
domain: Retail Analytics
defines: `Returned Quantity` measure (named `Return Quantity` in the web and catalog views)
metric_views: [store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [return quantity, units returned]
state: PUBLISHED
---
# Returned Quantity

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Returned Quantity | `Returned Quantity` measure (named `Return Quantity` in the web and catalog views) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Returned Quantity** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Units of merchandise returned per line: SUM(return_quantity) in the gold returns metric views.

## Definition
Units of merchandise returned per return line, aggregated as SUM(return_quantity). The store view exposes this as `Returned Quantity`; the web and catalog views expose it as `Return Quantity`.

## Business use
Volume-based size of returns; the numerator of unit-based Return Rate, against Sales Quantity as denominator.

## Examples
SELECT `Brand`, MEASURE(`Returned Quantity`) FROM workspace.gold.store_returns_metrics GROUP BY ALL

## Synonyms

return quantity, units returned

## Metric Views

- [store_returns_metrics](../metrics_views/store_returns_metrics.md)
- [web_returns_metrics](../metrics_views/web_returns_metrics.md)
- [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md)

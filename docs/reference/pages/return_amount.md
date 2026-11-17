---
c4_level: 4
type: page
page: Return Amount
page_id: 3a54b353-7853-4f76-bfa5-59aee1e5e407
domain: Retail Analytics
defines: `Return Amount` measure
metric_views: [store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [refund value, returned value]
state: PUBLISHED
---
# Return Amount

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Return Amount | `Return Amount` measure | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Return Amount** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Merchandise value returned per line: SUM(return_amount) in the gold store, web, and catalog returns metric views.

## Definition
Merchandise value given back per return line, aggregated as SUM(return_amount) in the gold store, web, and catalog returns metric views.

## Business use
Value-based size of returns per channel; the numerator of value-based Return Rate and a component of Net Loss.

## Examples
SELECT `Store Name`, MEASURE(`Return Amount`) FROM workspace.gold.store_returns_metrics GROUP BY ALL

## Synonyms

refund value, returned value

## Metric Views

- [store_returns_metrics](../metrics_views/store_returns_metrics.md)
- [web_returns_metrics](../metrics_views/web_returns_metrics.md)
- [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md)

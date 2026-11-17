---
c4_level: 4
type: page
page: Return Fee
page_id: e1de9638-7d08-471c-b717-b4f2d85904d7
domain: Retail Analytics
defines: "`Fee` measure"
metric_views: [store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [restocking fee, return fees]
state: PUBLISHED
---
# Return Fee

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Return Fee | `Fee` measure | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Return Fee** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Handling fee charged on a returned item: SUM(return_fee) exposed as the Fee measure in the gold returns metric views.

## Definition
Handling fee charged on a returned item, aggregated as SUM(return_fee) and exposed as the `Fee` measure in the gold store, web, and catalog returns metric views.

## Business use
Operational cost of processing returns; a component of the overall Net Loss.

## Examples
SELECT `Store Name`, MEASURE(`Fee`) FROM workspace.gold.store_returns_metrics GROUP BY ALL

## Synonyms

restocking fee, return fees


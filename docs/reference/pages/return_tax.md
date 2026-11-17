---
c4_level: 4
type: page
page: Return Tax
page_id: a233d8e2-a8b0-4ad7-a38a-fb4a61b18127
domain: Retail Analytics
defines: "`Return Tax` measure"
metric_views: [store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [tax on returns]
state: PUBLISHED
---
# Return Tax

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Return Tax | `Return Tax` measure | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Return Tax** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Tax portion of a returned line: SUM(return_tax) in the gold store, web, and catalog returns metric views.

## Definition
The tax portion associated with a returned line, aggregated as SUM(return_tax) and exposed as the `Return Tax` measure in the gold store, web, and catalog returns metric views.

## Business use
Reconciles pre-tax and post-tax return value; distinct from the base Return Amount.

## Examples
SELECT `Brand`, MEASURE(`Return Tax`) FROM workspace.gold.web_returns_metrics GROUP BY ALL

## Synonyms

tax on returns


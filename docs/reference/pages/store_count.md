---
c4_level: 4
type: page
page: Store Count
page_id: 5121027f-6eb4-4110-8886-c97dae84dfe1
domain: Retail Analytics
defines: "`Store Count` measure"
metric_views: [store_metrics]
synonyms: [number of stores, store footprint]
state: PUBLISHED
---
# Store Count

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Store Count | `Store Count` measure | [store_metrics](../metrics_views/store_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Store Count** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Distinct retail stores in the store master: COUNT(store_key) in workspace.gold.store_metrics.

## Definition
Number of distinct retail stores in the store master, computed as COUNT(store_key) in workspace.gold.store_metrics.

## Business use
Footprint analysis by store, city, or state; store joins to sales and return facts via store_key.

## Examples
SELECT `State`, MEASURE(`Store Count`) FROM workspace.gold.store_metrics GROUP BY ALL

## Synonyms

number of stores, store footprint

## Metric Views

- [store_metrics](../metrics_views/store_metrics.md)

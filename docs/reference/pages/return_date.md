---
c4_level: 4
type: page
page: Return Date
page_id: 69e1de8c-f621-4c25-88d7-8693cada104d
domain: Retail Analytics
defines: `Return Date` dimension
metric_views: [store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [returned date]
state: PUBLISHED
---
# Return Date

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Return Date | `Return Date` dimension | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Return Date** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Calendar date a return occurred (returned_date); returns time series must use it, not the original sold date.

## Definition
The calendar date a return occurred, carried as returned_date and joined through date_key to dim_date, exposed as the `Return Date` dimension in the gold store, web, and catalog returns metric views.

## Business use
All returns time series must be based on Return Date, not the sold date of the original transaction.

## Examples
Monthly Return Amount trend grouped by Return Date from workspace.gold.store_returns_metrics.

## Synonyms

returned date

## Metric Views

- [store_returns_metrics](../metrics_views/store_returns_metrics.md)
- [web_returns_metrics](../metrics_views/web_returns_metrics.md)
- [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md)

---
c4_level: 4
type: page
page: Net Loss
page_id: 08074fcc-ab22-4426-9a55-98d237c4dbae
domain: Retail Analytics
defines: `Net Loss` measure
metric_views: [store_returns_metrics, web_returns_metrics, catalog_returns_metrics]
synonyms: [loss on returns, return loss]
state: PUBLISHED
---
# Net Loss

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Net Loss | `Net Loss` measure | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Net Loss** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Net financial loss on returned items after fees and costs: SUM(net_loss) in the gold returns metric views.

## Definition
Net financial impact of a return line — the return amount adjusted for fees and associated costs — recorded per return line and aggregated as SUM(net_loss) in the gold store, web, and catalog returns metric views.

## Business use
Quantifies the true cost of returns rather than gross returned value. Combine with Return Rate to see whether returns are both frequent and costly.

## Examples
Net Loss per channel: SUM(net_loss) grouped by sales channel from the three gold returns metric views.

## Synonyms

loss on returns, return loss

## Metric Views

- [store_returns_metrics](../metrics_views/store_returns_metrics.md)
- [web_returns_metrics](../metrics_views/web_returns_metrics.md)
- [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md)

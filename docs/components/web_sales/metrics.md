---
c4_level: 3
module: web_sales
component: metrics
entities: [WebSalesMetrics]
tables: [gold.web_sales_enriched]
---
# Web-Sales Metrics

| module | component | entities | tables |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | metrics | WebSalesMetrics | [gold.web_sales_enriched](../../reference/tables/gold.web_sales_enriched.md) |

> **C4 Level 3 — Component.** The governed web-sales metrics: one named definition each, read by Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `WebSalesMetrics` | [`gold.web_sales_enriched`](../../reference/tables/gold.web_sales_enriched.md) | — | The Metric View `workspace.gold.web_sales_metrics`, defined in [reference/metrics_views/web_sales_metrics.md](../../reference/metrics_views/web_sales_metrics.md). |

Every metric stands on the **Web-Sales Line** object (the fact). The Metric View reads
the wide `gold.web_sales_enriched`, so each dimension is one column on that table. `Net
Sales` and `Quantity Sold` carry the same name and expression as the store and catalog metric
views; the transaction count here is `Order Count`, the same as catalog.

The authoritative definition — every measure, every dimension, and the YAML the backend
creates the view from — is the L4 reference file
[reference/metrics_views/web_sales_metrics.md](../../reference/metrics_views/web_sales_metrics.md).
There is no second copy of the YAML anywhere in the repository.

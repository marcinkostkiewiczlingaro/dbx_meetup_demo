---
c4_level: 3
module: store_sales
component: metrics
entities: [StoreSalesMetrics]
tables: [gold.store_sales_enriched]
---
# Store-Sales Metrics

| module | component | entities | tables |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | metrics | StoreSalesMetrics | [gold.store_sales_enriched](../../reference/tables/gold.store_sales_enriched.md) |

> **C4 Level 3 — Component.** The governed store-sales metrics: one named definition each, read by the dashboard and Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `StoreSalesMetrics` | [`gold.store_sales_enriched`](../../reference/tables/gold.store_sales_enriched.md) | — | The Metric View `workspace.gold.store_sales_metrics`, defined in [reference/metrics_views/store_sales_metrics.md](../../reference/metrics_views/store_sales_metrics.md). |

Every metric stands on the **Store-Sales Line** object (the fact). The Metric View reads the
wide `gold.store_sales_enriched`, so each dimension is one column on that table. `Net Sales`
and `Quantity Sold` carry the same name and expression as the catalog and web metric views;
the transaction count here is `Ticket Count` (the store sells by ticket).

The authoritative definition — every measure, every dimension, and the YAML the backend
creates the view from — is the L4 reference file
[reference/metrics_views/store_sales_metrics.md](../../reference/metrics_views/store_sales_metrics.md).
There is no second copy of the YAML anywhere in the repository.

---
c4_level: 3
module: catalog_sales
component: metrics
entities: [CatalogSalesMetrics]
tables: [gold.catalog_sales_enriched]
---
# Catalog-Sales Metrics

| module | component | entities | tables |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | metrics | CatalogSalesMetrics | [gold.catalog_sales_enriched](../../reference/tables/gold.catalog_sales_enriched.md) |

> **C4 Level 3 — Component.** The governed catalog-sales metrics: one named definition each, read by Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `CatalogSalesMetrics` | [`gold.catalog_sales_enriched`](../../reference/tables/gold.catalog_sales_enriched.md) | — | The Metric View `workspace.gold.catalog_sales_metrics`, defined in [reference/metrics_views/catalog_sales_metrics.md](../../reference/metrics_views/catalog_sales_metrics.md). |

Every metric stands on the **Catalog-Sales Line** object (the fact). The Metric View reads
the wide `gold.catalog_sales_enriched`, so each dimension is one column on that table. `Net
Sales` and `Quantity Sold` carry the same name and expression as the store and web metric
views; the transaction count here is `Order Count`, the same as web.

The authoritative definition — every measure, every dimension, and the YAML the backend
creates the view from — is the L4 reference file
[reference/metrics_views/catalog_sales_metrics.md](../../reference/metrics_views/catalog_sales_metrics.md).
There is no second copy of the YAML anywhere in the repository.

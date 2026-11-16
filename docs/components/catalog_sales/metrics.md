---
c4_level: 3
module: catalog_sales
component: metrics
entities: [CatalogSalesMetrics, CatalogReturnsMetrics]
tables: [gold.fct_catalog_sales, gold.fct_catalog_returns]
---
# Catalog-Sales Metrics

| module | component | entities | tables |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | metrics | CatalogSalesMetrics · CatalogReturnsMetrics | [gold.fct_catalog_sales](../../reference/tables/gold.fct_catalog_sales.md) · [gold.fct_catalog_returns](../../reference/tables/gold.fct_catalog_returns.md) |

> **C4 Level 3 — Component.** The governed catalog Metric Views: one named definition each, read by Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `CatalogSalesMetrics` | [`gold.fct_catalog_sales`](../../reference/tables/gold.fct_catalog_sales.md) | — | The Metric View `workspace.gold.catalog_sales_metrics`, defined in [reference/metrics_views/catalog_sales_metrics.md](../../reference/metrics_views/catalog_sales_metrics.md). |
| `CatalogReturnsMetrics` | [`gold.fct_catalog_returns`](../../reference/tables/gold.fct_catalog_returns.md) | — | The Metric View `workspace.gold.catalog_returns_metrics`, defined in [reference/metrics_views/catalog_returns_metrics.md](../../reference/metrics_views/catalog_returns_metrics.md). |

Each Metric View reads a gold `fct_*` table directly and joins the dimensions on their
surrogate keys with explicit `on:` expressions — no pre-joined copy of the star schema.
`Gross Sales` and `Sales Quantity` carry the same name and expression as the store and web
sales views — one name for one thing.

The authoritative definition of each view — every measure, every dimension, and the YAML the
backend creates the view from — is its L4 reference file under
[reference/metrics_views/](../../reference/metrics_views/README.md). There is no second copy
of the YAML anywhere in the repository.

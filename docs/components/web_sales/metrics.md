---
c4_level: 3
module: web_sales
component: metrics
entities: [WebSalesMetrics, WebReturnsMetrics]
tables: [gold.fct_web_sales, gold.fct_web_returns]
---
# Web-Sales Metrics

| module | component | entities | tables |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | metrics | WebSalesMetrics · WebReturnsMetrics | [gold.fct_web_sales](../../reference/tables/gold.fct_web_sales.md) · [gold.fct_web_returns](../../reference/tables/gold.fct_web_returns.md) |

> **C4 Level 3 — Component.** The governed web Metric Views: one named definition each, read by Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `WebSalesMetrics` | [`gold.fct_web_sales`](../../reference/tables/gold.fct_web_sales.md) | — | The Metric View `workspace.gold.web_sales_metrics`, defined in [reference/metrics_views/web_sales_metrics.md](../../reference/metrics_views/web_sales_metrics.md). |
| `WebReturnsMetrics` | [`gold.fct_web_returns`](../../reference/tables/gold.fct_web_returns.md) | — | The Metric View `workspace.gold.web_returns_metrics`, defined in [reference/metrics_views/web_returns_metrics.md](../../reference/metrics_views/web_returns_metrics.md). |

Each Metric View reads a gold `fct_*` table directly and joins the dimensions on their
surrogate keys with explicit `on:` expressions — no pre-joined copy of the star schema.
`Gross Sales` and `Sales Quantity` carry the same name and expression as the store and
catalog sales views — one name for one thing.

The authoritative definition of each view — every measure, every dimension, and the YAML the
backend creates the view from — is its L4 reference file under
[reference/metrics_views/](../../reference/metrics_views/README.md). There is no second copy
of the YAML anywhere in the repository.

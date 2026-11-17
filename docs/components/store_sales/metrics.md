---
c4_level: 3
module: store_sales
component: metrics
entities: [StoreSalesMetrics, StoreReturnsMetrics, StoreMetrics]
tables: [gold.fct_store_sales, gold.fct_store_returns, gold.dim_store]
---
# Store-Sales Metrics

| module | component | entities | tables |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | metrics | StoreSalesMetrics · StoreReturnsMetrics · StoreMetrics | [gold.fct_store_sales](../../reference/tables/gold.fct_store_sales.md) · [gold.fct_store_returns](../../reference/tables/gold.fct_store_returns.md) · [gold.dim_store](../../reference/tables/gold.dim_store.md) |

> **C4 Level 3 — Component.** The governed store Metric Views: one named definition each, read by the dashboard and Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `StoreSalesMetrics` | [`gold.fct_store_sales`](../../reference/tables/gold.fct_store_sales.md) | — | The Metric View `workspace.gold.store_sales_metrics`, defined in [reference/metrics_views/store_sales_metrics.md](../../reference/metrics_views/store_sales_metrics.md). |
| `StoreReturnsMetrics` | [`gold.fct_store_returns`](../../reference/tables/gold.fct_store_returns.md) | — | The Metric View `workspace.gold.store_returns_metrics`, defined in [reference/metrics_views/store_returns_metrics.md](../../reference/metrics_views/store_returns_metrics.md). |
| `StoreMetrics` | [`gold.dim_store`](../../reference/tables/gold.dim_store.md) | — | The Metric View `workspace.gold.store_metrics`, defined in [reference/metrics_views/store_metrics.md](../../reference/metrics_views/store_metrics.md). |

Each Metric View reads a gold `fct_*`/`dim_*` table directly and joins the dimensions on
their surrogate keys with explicit `on:` expressions — no pre-joined copy of the star schema.
`Gross Sales` and `Sales Quantity` carry the same name and expression as the catalog and web
sales views — one name for one thing.

The authoritative definition of each view — every measure, every dimension, and the YAML the
backend creates the view from — is its L4 reference file under
[reference/metrics_views/](../../reference/metrics_views/README.md). There is no second copy
of the YAML anywhere in the repository.

## Pages

Genie knowledge pages (business terms) governed over these Metric Views. Each page is the
definition Genie reads for the term; see [reference/pages/](../../reference/pages/README.md).

- [Gross Sales](../../reference/pages/gross_sales.md)
- [Net Sales](../../reference/pages/net_sales.md)
- [Net Paid](../../reference/pages/net_paid.md)
- [Net Profit](../../reference/pages/net_profit.md)
- [Sales Quantity](../../reference/pages/sales_quantity.md)
- [Return Amount](../../reference/pages/return_amount.md)
- [Returned Quantity](../../reference/pages/returned_quantity.md)
- [Return Tax](../../reference/pages/return_tax.md)
- [Return Fee](../../reference/pages/return_fee.md)
- [Net Loss](../../reference/pages/net_loss.md)
- [Return Rate](../../reference/pages/return_rate.md)
- [Return Date](../../reference/pages/return_date.md)
- [Store Count](../../reference/pages/store_count.md)

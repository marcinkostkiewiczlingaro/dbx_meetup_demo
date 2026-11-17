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

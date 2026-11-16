---
c4_level: 3
module: core
component: metrics
entities: [ItemMetrics, PromotionMetrics, CustomerMetrics]
tables: [gold.dim_item, gold.dim_promotion, gold.dim_customer]
---
# Core Metrics

| module | component | entities | tables |
|---|---|---|---|
| [core](../../modules/core.md) | metrics | ItemMetrics · PromotionMetrics · CustomerMetrics | [gold.dim_item](../../reference/tables/gold.dim_item.md) · [gold.dim_promotion](../../reference/tables/gold.dim_promotion.md) · [gold.dim_customer](../../reference/tables/gold.dim_customer.md) |

> **C4 Level 3 — Component.** The governed core-dimension Metric Views: one named definition each, read by Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `ItemMetrics` | [`gold.dim_item`](../../reference/tables/gold.dim_item.md) | — | The Metric View `workspace.gold.item_metrics`, defined in [reference/metrics_views/item_metrics.md](../../reference/metrics_views/item_metrics.md). |
| `PromotionMetrics` | [`gold.dim_promotion`](../../reference/tables/gold.dim_promotion.md) | — | The Metric View `workspace.gold.promotion_metrics`, defined in [reference/metrics_views/promotion_metrics.md](../../reference/metrics_views/promotion_metrics.md). |
| `CustomerMetrics` | [`gold.dim_customer`](../../reference/tables/gold.dim_customer.md) | — | The Metric View `workspace.gold.customer_metrics`, defined in [reference/metrics_views/customer_metrics.md](../../reference/metrics_views/customer_metrics.md). |

Each Metric View reads a conformed gold dimension directly and needs no joins. It counts the
dimension's rows and exposes its descriptive attributes for grouping.

The authoritative definition of each view — every measure, every dimension, and the YAML the
backend creates the view from — is its L4 reference file under
[reference/metrics_views/](../../reference/metrics_views/README.md). There is no second copy
of the YAML anywhere in the repository.

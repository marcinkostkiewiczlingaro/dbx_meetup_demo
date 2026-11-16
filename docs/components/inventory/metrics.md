---
c4_level: 3
module: inventory
component: metrics
entities: [InventoryMetrics]
tables: [gold.fct_inventory]
---
# Inventory Metrics

| module | component | entities | tables |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | metrics | InventoryMetrics | [gold.fct_inventory](../../reference/tables/gold.fct_inventory.md) |

> **C4 Level 3 — Component.** The governed inventory Metric View: one named definition, read by Genie so a number always traces back to one source.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `InventoryMetrics` | [`gold.fct_inventory`](../../reference/tables/gold.fct_inventory.md) | — | The Metric View `workspace.gold.inventory_metrics`, defined in [reference/metrics_views/inventory_metrics.md](../../reference/metrics_views/inventory_metrics.md). |

The Metric View reads the `gold.fct_inventory` stock-snapshot fact directly and joins
`dim_item`, `dim_warehouse`, and `dim_date` on their surrogate keys with explicit `on:`
expressions — no pre-joined copy of the star schema.

The authoritative definition — every measure, every dimension, and the YAML the backend
creates the view from — is its L4 reference file
[reference/metrics_views/inventory_metrics.md](../../reference/metrics_views/inventory_metrics.md).
There is no second copy of the YAML anywhere in the repository.

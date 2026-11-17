---
c4_level: 4
type: metric_view
metric_view: inventory_metrics
source: workspace.gold.fct_inventory
created_as: workspace.gold.inventory_metrics
domain: Retail Analytics/Shared Dimensions
component: components/inventory/metrics.md
---
# Metric View — inventory_metrics

| module | component | metric view | source |
|---|---|---|---|
| [inventory](../../modules/inventory.md) | [metrics](../../components/inventory/metrics.md) | `workspace.gold.inventory_metrics` | [gold.fct_inventory](../tables/gold.fct_inventory.md) |

> **C4 Level 4 — Metric View.** The governed definition of the inventory metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML. Domain: **Retail Analytics / Shared Dimensions** (see [domains registry](../../domains/README.md)).

The Metric View reads the `gold.fct_inventory` stock-snapshot fact and joins `dim_item`,
`dim_warehouse`, and `dim_date` on their surrogate keys. Each row is one item × warehouse ×
date on-hand quantity.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Inventory Quantity | `SUM(quantity_on_hand)` | Total units on hand across the snapshots. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Item ID | `item.item_id` | Business id of the item. |
| Brand | `item.brand` | Brand of the item. |
| Warehouse ID | `warehouse.warehouse_id` | Business id of the warehouse. |
| Warehouse Name | `warehouse.warehouse_name` | Warehouse holding the stock. |
| Snapshot Date | `snapshot_date` | Calendar day of the stock snapshot. |

## Pages

Genie knowledge pages (business terms) governed for this view, each the
definition Genie reads for the term:

- [Inventory Quantity](../pages/inventory_quantity.md)

## Definition

```yaml
version: 1.1
source: workspace.gold.fct_inventory
joins:
  - name: item
    source: workspace.gold.dim_item
    on: source.item_key = item.item_key
  - name: warehouse
    source: workspace.gold.dim_warehouse
    on: source.warehouse_key = warehouse.warehouse_key
  - name: date_dim
    source: workspace.gold.dim_date
    on: source.date_key = date_dim.date_key
dimensions:
  - name: Item ID
    expr: item.item_id
  - name: Brand
    expr: item.brand
  - name: Warehouse ID
    expr: warehouse.warehouse_id
  - name: Warehouse Name
    expr: warehouse.warehouse_name
  - name: Snapshot Date
    expr: snapshot_date
measures:
  - name: Inventory Quantity
    expr: SUM(quantity_on_hand)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.inventory_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Warehouse Name`, MEASURE(`Inventory Quantity`)
FROM workspace.gold.inventory_metrics
GROUP BY `Warehouse Name`
ORDER BY 2 DESC;
```

---
c4_level: 4
type: metric_view
metric_view: item_metrics
source: workspace.gold.dim_item
created_as: workspace.gold.item_metrics
component: components/core/metrics.md
---
# Metric View — item_metrics

| module | component | metric view | source |
|---|---|---|---|
| [core](../../modules/core.md) | [metrics](../../components/core/metrics.md) | `workspace.gold.item_metrics` | [gold.dim_item](../tables/gold.dim_item.md) |

> **C4 Level 4 — Metric View.** The governed definition of the item metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the `gold.dim_item` dimension directly and needs no joins. It counts
items and exposes their descriptive attributes for grouping.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Item Count | `COUNT(item_key)` | Number of items. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Item Key | `item_key` | Surrogate key of the item. |
| Item ID | `item_id` | Business id of the item. |
| Item Name | `item_name` | Name of the item. |
| Brand | `brand` | Brand of the item. |
| Manufacturer | `manufacturer` | Manufacturer of the item. |
| Category | `category` | Category of the item. |
| Class | `class` | Class of the item. |

## Pages

Genie knowledge pages (business terms) governed for this view, each the
definition Genie reads for the term:

- [Item Count](../pages/item_count.md)

## Definition

```yaml
version: 1.1
source: workspace.gold.dim_item
dimensions:
  - name: Item Key
    expr: item_key
  - name: Item ID
    expr: item_id
  - name: Item Name
    expr: item_name
  - name: Brand
    expr: brand
  - name: Manufacturer
    expr: manufacturer
  - name: Category
    expr: category
  - name: Class
    expr: class
measures:
  - name: Item Count
    expr: COUNT(item_key)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.item_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Category`, MEASURE(`Item Count`)
FROM workspace.gold.item_metrics
GROUP BY `Category`
ORDER BY 2 DESC;
```

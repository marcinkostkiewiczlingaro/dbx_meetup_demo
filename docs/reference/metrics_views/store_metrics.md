---
c4_level: 4
type: metric_view
metric_view: store_metrics
source: workspace.gold.dim_store
created_as: workspace.gold.store_metrics
domain: Retail Analytics/Shared Dimensions
component: components/store_sales/metrics.md
---
# Metric View — store_metrics

| module | component | metric view | source |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [metrics](../../components/store_sales/metrics.md) | `workspace.gold.store_metrics` | [gold.dim_store](../tables/gold.dim_store.md) |

> **C4 Level 4 — Metric View.** The governed definition of the store metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML. Domain: **Retail Analytics / Shared Dimensions** (see [domains registry](../../domains/README.md)).

The Metric View reads the `gold.dim_store` dimension directly and needs no joins. It counts
stores and exposes their location attributes for grouping.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Store Count | `COUNT(store_key)` | Number of stores. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Store Key | `store_key` | Surrogate key of the store. |
| Store ID | `store_id` | Business id of the store. |
| Store Name | `store_name` | Name of the store. |
| City | `store_city` | City of the store. |
| State | `store_state` | State of the store. |

## Pages

Genie knowledge pages (business terms) governed for this view, each the
definition Genie reads for the term:

- [Store Count](../pages/store_count.md)

## Definition

```yaml
version: 1.1
source: workspace.gold.dim_store
dimensions:
  - name: Store Key
    expr: store_key
  - name: Store ID
    expr: store_id
  - name: Store Name
    expr: store_name
  - name: City
    expr: store_city
  - name: State
    expr: store_state
measures:
  - name: Store Count
    expr: COUNT(store_key)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.store_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `State`, MEASURE(`Store Count`)
FROM workspace.gold.store_metrics
GROUP BY `State`
ORDER BY 2 DESC;
```

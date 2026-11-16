---
c4_level: 4
type: metric_view
metric_view: customer_metrics
source: workspace.gold.dim_customer
created_as: workspace.gold.customer_metrics
component: components/core/metrics.md
---
# Metric View — customer_metrics

| module | component | metric view | source |
|---|---|---|---|
| [core](../../modules/core.md) | [metrics](../../components/core/metrics.md) | `workspace.gold.customer_metrics` | [gold.dim_customer](../tables/gold.dim_customer.md) |

> **C4 Level 4 — Metric View.** The governed definition of the customer metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the `gold.dim_customer` dimension directly and needs no joins. Gold
carries no demographics or household keys, so gender, marital status, education, and buy
potential are not reproduced; city, state, and country live on the dimension itself.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Customer Count | `COUNT(customer_key)` | Number of customers. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Customer Key | `customer_key` | Surrogate key of the customer. |
| Customer ID | `customer_id` | Business id of the customer. |
| Preferred Customer | `is_preferred_customer` | Whether the customer is a preferred customer. |
| City | `customer_city` | City of the customer. |
| State | `customer_state` | State of the customer. |
| Country | `customer_country` | Country of the customer. |

## Definition

```yaml
version: 1.1
source: workspace.gold.dim_customer
dimensions:
  - name: Customer Key
    expr: customer_key
  - name: Customer ID
    expr: customer_id
  - name: Preferred Customer
    expr: is_preferred_customer
  - name: City
    expr: customer_city
  - name: State
    expr: customer_state
  - name: Country
    expr: customer_country
measures:
  - name: Customer Count
    expr: COUNT(customer_key)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.customer_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `State`, MEASURE(`Customer Count`)
FROM workspace.gold.customer_metrics
GROUP BY `State`
ORDER BY 2 DESC;
```

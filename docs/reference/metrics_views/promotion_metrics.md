---
c4_level: 4
type: metric_view
metric_view: promotion_metrics
source: workspace.gold.dim_promotion
created_as: workspace.gold.promotion_metrics
domain: Retail Analytics/Shared Dimensions
component: components/core/metrics.md
---
# Metric View — promotion_metrics

| module | component | metric view | source |
|---|---|---|---|
| [core](../../modules/core.md) | [metrics](../../components/core/metrics.md) | `workspace.gold.promotion_metrics` | [gold.dim_promotion](../tables/gold.dim_promotion.md) |

> **C4 Level 4 — Metric View.** The governed definition of the promotion metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML. Domain: **Retail Analytics / Shared Dimensions** (see [domains registry](../../domains/README.md)).

The Metric View reads the `gold.dim_promotion` dimension directly and needs no joins. Gold
models the promotion channel as boolean flags (`channel_email`, `channel_tv`) instead of
bronze's single channel string.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Promotion Count | `COUNT(promo_key)` | Number of promotions. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Promotion Key | `promo_key` | Surrogate key of the promotion. |
| Promotion ID | `promo_id` | Business id of the promotion. |
| Promotion Name | `promo_name` | Name of the promotion. |
| Purpose | `promo_purpose` | Purpose of the promotion. |
| Email Channel | `channel_email` | Whether the promotion ran on email. |
| TV Channel | `channel_tv` | Whether the promotion ran on TV. |
| Discount Active | `is_discount_active` | Whether a discount is active. |

## Pages

Genie knowledge pages (business terms) governed for this view, each the
definition Genie reads for the term:

- [Promotion Count](../pages/promotion_count.md)

## Definition

```yaml
version: 1.1
source: workspace.gold.dim_promotion
dimensions:
  - name: Promotion Key
    expr: promo_key
  - name: Promotion ID
    expr: promo_id
  - name: Promotion Name
    expr: promo_name
  - name: Purpose
    expr: promo_purpose
  - name: Email Channel
    expr: channel_email
  - name: TV Channel
    expr: channel_tv
  - name: Discount Active
    expr: is_discount_active
measures:
  - name: Promotion Count
    expr: COUNT(promo_key)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.promotion_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Purpose`, MEASURE(`Promotion Count`)
FROM workspace.gold.promotion_metrics
GROUP BY `Purpose`
ORDER BY 2 DESC;
```

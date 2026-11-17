---
c4_level: 4
type: metric_view
metric_view: catalog_returns_metrics
source: workspace.gold.fct_catalog_returns
created_as: workspace.gold.catalog_returns_metrics
domain: Retail Analytics/Returns
component: components/catalog_sales/metrics.md
---
# Metric View — catalog_returns_metrics

| module | component | metric view | source |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [metrics](../../components/catalog_sales/metrics.md) | `workspace.gold.catalog_returns_metrics` | [gold.fct_catalog_returns](../tables/gold.fct_catalog_returns.md) |

> **C4 Level 4 — Metric View.** The governed definition of the catalog-returns metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML. Domain: **Retail Analytics / Returns** (see [domains registry](../../domains/README.md)).

The Metric View reads the `gold.fct_catalog_returns` fact and joins `dim_customer`,
`dim_item`, `dim_call_center`, `dim_catalog_page`, `dim_ship_mode`, and `dim_date` on their
surrogate keys. Gold collapses the refunded and returning customer into one `customer_key`
and carries no reason, warehouse, cash, credit, ship-cost, or reversed-charge columns, so
those bronze measures are not reproduced.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Return Quantity | `SUM(return_quantity)` | Total units returned. |
| Return Amount | `SUM(return_amount)` | Total value returned. |
| Net Loss | `SUM(net_loss)` | Total net loss on the returns. |
| Fee | `SUM(return_fee)` | Total return fee charged. |
| Return Tax | `SUM(return_tax)` | Total tax on the returned value. |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Customer ID | `customer.customer_id` | Business id of the customer. |
| Item ID | `item.item_id` | Business id of the item. |
| Brand | `item.brand` | Brand of the item. |
| Call Center | `call_center.call_center_id` | Call center that handled the return. |
| Catalog Page | `catalog_page.catalog_page_id` | Catalog page the order came from. |
| Ship Mode | `ship_mode.ship_mode_type` | Shipping method of the order. |
| Return Date | `returned_date` | Calendar day of the return. |
| Order Number | `order_number` | Catalog-return order the line belongs to. |

## Pages

Genie knowledge pages (business terms) governed for this view, each the
definition Genie reads for the term:

- [Return Amount](../pages/return_amount.md)
- [Returned Quantity](../pages/returned_quantity.md)
- [Return Tax](../pages/return_tax.md)
- [Return Fee](../pages/return_fee.md)
- [Net Loss](../pages/net_loss.md)
- [Return Rate](../pages/return_rate.md)
- [Return Date](../pages/return_date.md)

## Definition

```yaml
version: 1.1
source: workspace.gold.fct_catalog_returns
joins:
  - name: customer
    source: workspace.gold.dim_customer
    on: source.customer_key = customer.customer_key
  - name: item
    source: workspace.gold.dim_item
    on: source.item_key = item.item_key
  - name: call_center
    source: workspace.gold.dim_call_center
    on: source.call_center_key = call_center.call_center_key
  - name: catalog_page
    source: workspace.gold.dim_catalog_page
    on: source.catalog_page_key = catalog_page.catalog_page_key
  - name: ship_mode
    source: workspace.gold.dim_ship_mode
    on: source.ship_mode_key = ship_mode.ship_mode_key
  - name: date_dim
    source: workspace.gold.dim_date
    on: source.date_key = date_dim.date_key
dimensions:
  - name: Customer ID
    expr: customer.customer_id
  - name: Item ID
    expr: item.item_id
  - name: Brand
    expr: item.brand
  - name: Call Center
    expr: call_center.call_center_id
  - name: Catalog Page
    expr: catalog_page.catalog_page_id
  - name: Ship Mode
    expr: ship_mode.ship_mode_type
  - name: Return Date
    expr: returned_date
  - name: Order Number
    expr: order_number
measures:
  - name: Return Quantity
    expr: SUM(return_quantity)
  - name: Return Amount
    expr: SUM(return_amount)
  - name: Net Loss
    expr: SUM(net_loss)
  - name: Fee
    expr: SUM(return_fee)
  - name: Return Tax
    expr: SUM(return_tax)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.catalog_returns_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Ship Mode`, MEASURE(`Return Amount`), MEASURE(`Return Quantity`)
FROM workspace.gold.catalog_returns_metrics
GROUP BY `Ship Mode`
ORDER BY 2 DESC;
```

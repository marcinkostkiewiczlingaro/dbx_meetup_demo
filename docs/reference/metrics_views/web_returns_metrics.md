---
c4_level: 4
type: metric_view
metric_view: web_returns_metrics
source: workspace.gold.fct_web_returns
created_as: workspace.gold.web_returns_metrics
component: components/web_sales/metrics.md
---
# Metric View — web_returns_metrics

| module | component | metric view | source |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | [metrics](../../components/web_sales/metrics.md) | `workspace.gold.web_returns_metrics` | [gold.fct_web_returns](../tables/gold.fct_web_returns.md) |

> **C4 Level 4 — Metric View.** The governed definition of the web-returns metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the `gold.fct_web_returns` fact and joins `dim_customer`, `dim_item`,
`dim_web_page`, and `dim_date` on their surrogate keys. Gold collapses the refunded and
returning customer into one `customer_key` and carries no reason, cash, credit, ship-cost,
or reversed-charge columns, so those bronze measures are not reproduced.

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
| Web Page ID | `web_page.web_page_id` | Web page the order came from. |
| Return Date | `returned_date` | Calendar day of the return. |
| Order Number | `order_number` | Web-return order the line belongs to. |

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
source: workspace.gold.fct_web_returns
joins:
  - name: customer
    source: workspace.gold.dim_customer
    on: source.customer_key = customer.customer_key
  - name: item
    source: workspace.gold.dim_item
    on: source.item_key = item.item_key
  - name: web_page
    source: workspace.gold.dim_web_page
    on: source.web_page_key = web_page.web_page_key
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
  - name: Web Page ID
    expr: web_page.web_page_id
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
CREATE OR REPLACE VIEW workspace.gold.web_returns_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Brand`, MEASURE(`Return Amount`), MEASURE(`Return Quantity`)
FROM workspace.gold.web_returns_metrics
GROUP BY `Brand`
ORDER BY 2 DESC;
```

---
c4_level: 4
type: metric_view
metric_view: catalog_sales_metrics
source: workspace.gold.fct_catalog_sales
created_as: workspace.gold.catalog_sales_metrics
component: components/catalog_sales/metrics.md
---
# Metric View — catalog_sales_metrics

| module | component | metric view | source |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [metrics](../../components/catalog_sales/metrics.md) | `workspace.gold.catalog_sales_metrics` | [gold.fct_catalog_sales](../tables/gold.fct_catalog_sales.md) |

> **C4 Level 4 — Metric View.** The governed definition of the catalog-sales metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the `gold.fct_catalog_sales` fact and joins the gold dimensions on
their surrogate keys — `dim_customer`, `dim_item`, `dim_promotion`, `dim_call_center`,
`dim_catalog_page`, `dim_ship_mode`, and `dim_date`. `Gross Sales`, `Net Paid`, and
`Sales Quantity` carry the same name and expression as the store and web metric views.

## Measures

| Measure | Expression | Description |
|---|---|---|
| Sales Quantity | `SUM(quantity)` | Total units sold. |
| Gross Sales | `SUM(sales_price * quantity)` | Sales price times quantity across lines. |
| Net Paid | `SUM(net_paid)` | Total net amount paid. |
| Net Profit | `SUM(net_profit)` | Total net profit across lines. |
| Wholesale Cost | `SUM(wholesale_cost)` | Total wholesale cost of the lines. |
| List Price | `SUM(list_price)` | Total list price of the lines. |
| Extended Discount Amount | `SUM(discount_amount)` | Total extended discount given. |
| Extended Sales Price | `SUM(sales_amount)` | Total extended sales price (net revenue). |

## Dimensions

| Dimension | Expression | Description |
|---|---|---|
| Item ID | `item.item_id` | Business id of the item. |
| Brand | `item.brand` | Brand of the item. |
| Customer ID | `customer.customer_id` | Business id of the customer. |
| Promotion Name | `promotion.promo_name` | Promotion the line is attributed to. |
| Call Center | `call_center.call_center_id` | Call center that took the order. |
| Catalog Page | `catalog_page.catalog_page_id` | Catalog page the order came from. |
| Ship Mode | `ship_mode.ship_mode_type` | Shipping method of the order. |
| Sold Date | `sold_date` | Calendar day of the sale. |
| Order Number | `order_number` | Catalog-sales order the line belongs to. |

## Pages

Genie knowledge pages (business terms) governed for this view, each the
definition Genie reads for the term:

- [Gross Sales](../pages/gross_sales.md)
- [Net Sales](../pages/net_sales.md)
- [Net Paid](../pages/net_paid.md)
- [Net Profit](../pages/net_profit.md)
- [Sales Quantity](../pages/sales_quantity.md)
- [Return Rate](../pages/return_rate.md)

## Definition

```yaml
version: 1.1
source: workspace.gold.fct_catalog_sales
joins:
  - name: customer
    source: workspace.gold.dim_customer
    on: source.customer_key = customer.customer_key
  - name: item
    source: workspace.gold.dim_item
    on: source.item_key = item.item_key
  - name: promotion
    source: workspace.gold.dim_promotion
    on: source.promo_key = promotion.promo_key
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
  - name: Item ID
    expr: item.item_id
  - name: Brand
    expr: item.brand
  - name: Customer ID
    expr: customer.customer_id
  - name: Promotion Name
    expr: promotion.promo_name
  - name: Call Center
    expr: call_center.call_center_id
  - name: Catalog Page
    expr: catalog_page.catalog_page_id
  - name: Ship Mode
    expr: ship_mode.ship_mode_type
  - name: Sold Date
    expr: sold_date
  - name: Order Number
    expr: order_number
measures:
  - name: Sales Quantity
    expr: SUM(quantity)
  - name: Gross Sales
    expr: SUM(sales_price * quantity)
  - name: Net Paid
    expr: SUM(net_paid)
  - name: Net Profit
    expr: SUM(net_profit)
  - name: Wholesale Cost
    expr: SUM(wholesale_cost)
  - name: List Price
    expr: SUM(list_price)
  - name: Extended Discount Amount
    expr: SUM(discount_amount)
  - name: Extended Sales Price
    expr: SUM(sales_amount)
```

## Deploy

A Metric View is a Unity Catalog object, not a bundle resource. The backend extracts the
`## Definition` YAML block above and runs it, so the documented definition and the deployed
object never drift:

```sql
CREATE OR REPLACE VIEW workspace.gold.catalog_sales_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Ship Mode`, MEASURE(`Extended Sales Price`), MEASURE(`Sales Quantity`)
FROM workspace.gold.catalog_sales_metrics
GROUP BY `Ship Mode`
ORDER BY 2 DESC;
```

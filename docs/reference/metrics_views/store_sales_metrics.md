---
c4_level: 4
type: metric_view
metric_view: store_sales_metrics
source: workspace.gold.fct_store_sales
created_as: workspace.gold.store_sales_metrics
component: components/store_sales/metrics.md
---
# Metric View — store_sales_metrics

| module | component | metric view | source |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [metrics](../../components/store_sales/metrics.md) | `workspace.gold.store_sales_metrics` | [gold.fct_store_sales](../tables/gold.fct_store_sales.md) |

> **C4 Level 4 — Metric View.** The governed definition of the store-sales metrics and the single source the backend creates the view from. The `## Definition` block below is the one authoritative copy of the YAML.

The Metric View reads the `gold.fct_store_sales` fact and joins the gold dimensions on their
surrogate keys — `dim_customer`, `dim_store`, `dim_item`, `dim_promotion`, and `dim_date`.
No pre-joined copy of the star schema exists; the join is declared here with explicit `on:`
expressions. Every measure and dimension name is the one business term the table docs, the
Genie space, and the dashboard spell the same way.

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
| Store ID | `store.store_id` | Business id of the store. |
| Store Name | `store.store_name` | Store where the sale happened. |
| Item ID | `item.item_id` | Business id of the item. |
| Brand | `item.brand` | Brand of the item. |
| Category | `item.category` | Category of the item. |
| Customer ID | `customer.customer_id` | Business id of the customer. |
| Promotion Name | `promotion.promo_name` | Promotion the line is attributed to. |
| Sold Date | `sold_date` | Calendar day of the sale. |
| Ticket Number | `ticket_number` | Store-sales ticket the line belongs to. |

## Definition

```yaml
version: 1.1
source: workspace.gold.fct_store_sales
joins:
  - name: customer
    source: workspace.gold.dim_customer
    on: source.customer_key = customer.customer_key
  - name: store
    source: workspace.gold.dim_store
    on: source.store_key = store.store_key
  - name: item
    source: workspace.gold.dim_item
    on: source.item_key = item.item_key
  - name: promotion
    source: workspace.gold.dim_promotion
    on: source.promo_key = promotion.promo_key
  - name: date_dim
    source: workspace.gold.dim_date
    on: source.date_key = date_dim.date_key
dimensions:
  - name: Store ID
    expr: store.store_id
  - name: Store Name
    expr: store.store_name
  - name: Item ID
    expr: item.item_id
  - name: Brand
    expr: item.brand
  - name: Category
    expr: item.category
  - name: Customer ID
    expr: customer.customer_id
  - name: Promotion Name
    expr: promotion.promo_name
  - name: Sold Date
    expr: sold_date
  - name: Ticket Number
    expr: ticket_number
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
CREATE OR REPLACE VIEW workspace.gold.store_sales_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- contents of the ## Definition block above
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Category`, MEASURE(`Extended Sales Price`), MEASURE(`Sales Quantity`)
FROM workspace.gold.store_sales_metrics
GROUP BY `Category`
ORDER BY 2 DESC;
```

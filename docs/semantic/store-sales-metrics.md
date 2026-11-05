# Semantic Model — Store-Sales Metrics

The semantic model defines each business metric once, in words, and binds it to the
exact expression in the Metric View (`metrics/store_sales_metric_view.yml`). An analyst
or Genie answer can trace any number back to this definition and its source.

Every metric stands on the **Sales Transaction** object (`gold.fct_store_sales`). The
dimensions below come from the linked Customer, Product, Store, and Date objects.

## Metrics

| Metric | Definition | Expression | Grain it rolls up from |
|---|---|---|---|
| Net Sales Amount | Total amount customers paid. | `SUM(net_sales_amount)` | sold line |
| Net Profit Amount | Total profit after cost. | `SUM(net_profit_amount)` | sold line |
| Gross Sales Amount | Total line value before discount. | `SUM(gross_sales_amount)` | sold line |
| Discount Amount | Total discount given. | `SUM(discount_amount)` | sold line |
| Quantity Sold | Total units sold. | `SUM(quantity)` | sold line |
| Order Count | Number of distinct sales tickets. | `COUNT(DISTINCT sales_ticket_number)` | ticket |
| Average Order Value | Net sales divided by order count. | `SUM(net_sales_amount) / COUNT(DISTINCT sales_ticket_number)` | ticket |

## Dimensions (slice any metric by these)

| Dimension | From object | Column |
|---|---|---|
| Calendar Date, Year | Date | `gold.dim_date` |
| Product Category, Brand | Product | `gold.dim_item` |
| Store Name, State | Store | `gold.dim_store` |
| Preferred Customer | Customer | `gold.dim_customer` |

## Traceability

- Business term → ontology property → gold column → source column: see each object-type
  file under `docs/ontology/object-types/`.
- Metric name here = measure name in the Metric View = the name Genie exposes. One name
  for one thing.

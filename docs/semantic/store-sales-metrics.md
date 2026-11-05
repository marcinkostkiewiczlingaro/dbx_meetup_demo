# Semantic Model — Bakery-Sales Metrics

The semantic model defines each business metric once, in words, and binds it to the
exact expression in the Metric View (`metrics/store_sales_metric_view.yml`). An analyst
or Genie answer can trace any number back to this definition and its source.

Every metric stands on the **Sales Transaction** object (`gold.fct_sales`). The
dimensions below come from the linked Customer, Product, Franchise, and Date objects.

## Metrics

| Metric | Definition | Expression | Grain it rolls up from |
|---|---|---|---|
| Total Revenue | Total money taken from sales. | `SUM(sales_amount)` | transaction |
| Quantity Sold | Total units sold. | `SUM(quantity)` | transaction |
| Transaction Count | Number of distinct sales. | `COUNT(DISTINCT sales_transaction_id)` | transaction |
| Average Transaction Value | Revenue divided by transaction count. | `SUM(sales_amount) / COUNT(DISTINCT sales_transaction_id)` | transaction |
| Units per Transaction | Units divided by transaction count. | `SUM(quantity) / COUNT(DISTINCT sales_transaction_id)` | transaction |

## Dimensions (slice any metric by these)

| Dimension | From object | Column |
|---|---|---|
| Sold Date, Month Name | Date | `gold.dim_date` |
| Product | Product | `gold.fct_sales.product_name` |
| Payment Method | Sales Transaction | `gold.fct_sales.payment_method` |
| Franchise, Franchise Country | Franchise | `gold.dim_franchise` |
| Customer Country | Customer | `gold.dim_customer` |

## Traceability

- Business term → ontology property → gold column → source column: see each object-type
  file under `docs/ontology/object-types/`.
- Metric name here = measure name in the Metric View = the name Genie exposes. One name
  for one thing.

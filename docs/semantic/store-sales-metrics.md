# Semantic Model — Bakery-Sales Metrics

The semantic model defines each business metric once, in words, and binds it to the
exact expression in the Metric View (`metrics/store_sales_metric_view.yml`). An analyst
or Genie answer can trace any number back to this definition and its source.

Every metric stands on the **Sales Transaction** object. The Metric View reads
`gold.sales_enriched` — the fact widened with descriptive columns — so every dimension
below is one column on that table, drawn from the Customer, Product, Franchise, and Date
objects.

## Metrics

| Metric | Definition | Expression | Grain it rolls up from |
|---|---|---|---|
| Total Revenue | Total money taken from sales. | `SUM(sales_amount)` | transaction |
| Quantity Sold | Total units sold. | `SUM(quantity)` | transaction |
| Transaction Count | Number of distinct sales. | `COUNT(DISTINCT sales_transaction_id)` | transaction |
| Average Transaction Value | Revenue divided by transaction count. | `SUM(sales_amount) / COUNT(DISTINCT sales_transaction_id)` | transaction |
| Units per Transaction | Units divided by transaction count. | `SUM(quantity) / COUNT(DISTINCT sales_transaction_id)` | transaction |

## Dimensions (slice any metric by these)

| Dimension | From object | Column in `gold.sales_enriched` |
|---|---|---|
| Sold Date, Month Name | Date | `sold_date`, `month_name` |
| Product | Product | `product_name` |
| Payment Method | Sales Transaction | `payment_method` |
| Franchise, Franchise Country | Franchise | `franchise_name`, `franchise_country` |
| Customer Country | Customer | `customer_country` |

## Traceability

- Business term → ontology property → gold column → source column: see each object-type
  file under `docs/ontology/object-types/`.
- Metric name here = measure name in the Metric View = the name Genie exposes. One name
  for one thing.

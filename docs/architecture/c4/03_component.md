# C4 Level 3 — Components (Gold star schema)

Inside the gold schema the components form a classic star: one fact surrounded by
four conformed dimensions. The Metric View reads the fact and joins the dimensions.

```mermaid
C4Component
  title Gold Star Schema — Components

  ContainerDb(fct, "gold.fct_store_sales", "Fact", "One row per sold line. Measures: net sales, net profit, quantity, discount.")
  ContainerDb(dimc, "gold.dim_customer", "Dimension", "One row per customer.")
  ContainerDb(dimi, "gold.dim_item", "Dimension", "One row per product.")
  ContainerDb(dims, "gold.dim_store", "Dimension", "One row per store.")
  ContainerDb(dimd, "gold.dim_date", "Dimension", "One row per calendar day.")

  Rel(fct, dimc, "customer_key")
  Rel(fct, dimi, "product_key")
  Rel(fct, dims, "store_key")
  Rel(fct, dimd, "date_key")
```

Each component is one SQL file in `src/gold/`. The foreign keys here are the same
links the ontology names (`docs/ontology/link-types.md`).

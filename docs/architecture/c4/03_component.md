# C4 Level 3 — Components (Gold star schema)

Inside the gold schema the components form a classic star: one fact surrounded by
conformed dimensions. The Metric View reads the fact and joins the dimensions.

```mermaid
C4Component
  title Gold Star Schema — Components

  ContainerDb(fct, "gold.fct_sales", "Fact", "One row per transaction. Measures: revenue, quantity, transaction count.")
  ContainerDb(dimc, "gold.dim_customer", "Dimension", "One row per customer.")
  ContainerDb(dimp, "gold.dim_product", "Dimension", "One row per product (derived from the fact).")
  ContainerDb(dimf, "gold.dim_franchise", "Dimension", "One row per franchise (store), with its supplier.")
  ContainerDb(dimd, "gold.dim_date", "Dimension", "One row per sales day (derived from the fact).")

  Rel(fct, dimc, "customer_key")
  Rel(fct, dimp, "product_name")
  Rel(fct, dimf, "franchise_key")
  Rel(fct, dimd, "sold_date")
```

Each component is one SQL file in `src/gold/`. Product and date have no source table in
the sample, so the pipeline derives them from the fact. The foreign keys here are the
same links the ontology names (`docs/ontology/link-types.md`).

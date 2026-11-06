---
opened: 2026-11-06
landed: 2026-11-06
---

# F005 · The demo spans three sales-channel domains on one shared set of conformed dimensions

The demo now has four pipelines instead of one. A `core` dimensions pipeline builds the
conformed customer, item, date, and promotion dimensions once. Three channel domains —
store, catalog, and web — each have their own pipeline, their own sales and returns facts,
their own channel dimensions (store; call center, catalog page, ship mode; web site, web
page), a wide `*_enriched` gold table, and a governed Metric View. Net Sales, Quantity
Sold, and the order/ticket count carry the same names and expressions across all three
channels, so one vocabulary holds the domains together. The documentation follows the
standard: one L2 module per domain plus `core`, their L3 components, L4 table and
metric-view references, and the ontology. Landed in merge `821a728`.

The work took three jobs: one built the pipelines and most docs but hit the 90-minute
timeout in the reference layer; a finish job wrote the missing web components and the L4
table schemas; the coordinator then fixed the store/core L4 navigation links that the
restructure had left pointing at the retired `pipeline` module paths. `databricks bundle
validate --target dev --profile free` passes and every docs navigation link resolves.

Next reader, before deploying: the live `store_sales` pipeline from F004 currently owns the
conformed dims (`gold.dim_customer`, `dim_date`, `dim_item`, `dim_promotion`). F005 moved
those to the new `core` pipeline. A Lakeflow table is owned by one pipeline, so deploying
F005 needs the old store-owned dims dropped first, then the `core` pipeline run before the
channel pipelines, so each conformed dim is created once by `core`. Nothing was deployed or
run in this feature; that is the owner's step.

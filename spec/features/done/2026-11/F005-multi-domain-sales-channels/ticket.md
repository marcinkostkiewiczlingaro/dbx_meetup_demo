---
opened: 2026-11-06
landed: 2026-11-06
---

# F005 · The demo spans three sales-channel domains on one shared set of conformed dimensions

## Outcome

A data engineer sees the demo as more than one subject area. The store, catalog, and web
sales channels each become their own domain with its own pipeline, and all three read one
shared set of conformed dimensions — customer, item, date, promotion — built once. An
analyst gets a governed Metric View per channel, all speaking the same business vocabulary,
so a term like Net Sales means the same across store, catalog, and web. This gives the talk
a richer, more realistic example: many pipelines, several domains, and one semantic
foundation that holds them together instead of three disconnected models.

## Scope

- Refactor the shared dimensions (customer + address, item, date, promotion) into a `core`
  dimensions pipeline that builds them once; the channel pipelines read them, not rebuild
  them. Start seam: extract the current `dim_customer`, `dim_item`, `dim_date`,
  `dim_promotion` out of the store-sales pipeline into `src/core/`.
- Add a catalog-sales domain (`catalog_sales` fact, grain cs_order_number × cs_item_sk, plus
  `catalog_returns`, with `call_center`, `catalog_page`, `ship_mode` dimensions) and a
  web-sales domain (`web_sales` fact, grain ws_order_number × ws_item_sk, plus `web_returns`,
  with `web_site`, `web_page` dimensions). Add `store_returns` to the existing store domain.
- Reorganize `src/` by domain: `src/core`, `src/store_sales`, `src/catalog_sales`,
  `src/web_sales`, each with bronze/silver/gold. One bundle, one pipeline resource per domain
  under `resources/`.
- Each channel domain gets a wide gold enriched table and a governed Metric View reference
  under `docs/reference/metrics_views/`, reading its channel fact plus the shared core dims.
- Document each domain as its own L2 module per the standard, with its L3 components and L4
  reference files; add the sales-channel and returns objects to the ontology.

## Out of scope

- An inventory domain (`inventory`, `warehouse`) and deep returns analytics — a natural next
  domain, not this one.
- Unity Catalog Domain governance objects — this feature adds subject-area pipelines and
  metric views; grouping them into UC Domain objects is a later Part 2 step.
- Deploying or running the new pipelines; that is the owner's demo-time step.

## Acceptance

- `databricks bundle validate --target dev --profile free` passes with one `core` pipeline
  and one pipeline per channel (store, catalog, web) as bundle resources.
- The conformed dimensions are defined once in `src/core/`; no channel pipeline redefines
  `dim_customer`, `dim_item`, `dim_date`, or `dim_promotion`.
- Each channel has a `*_enriched` gold table and a `docs/reference/metrics_views/*.md`
  reference with a `## Definition` YAML block; no metric-view YAML lives elsewhere.
- Net Sales, Quantity Sold, and Ticket/Order Count carry the same names and expressions
  across all three channel metric views.
- `docs/` has one L2 module per domain plus `core`, each following the standard
  (front-matter, inline table, blockquote; every L3 has `## Entities`).
- No `baker`/`bakehouse`/`bakery` match outside `spec/`.

## Notes

- Lakeflow tables are owned by one pipeline; the channel enriched tables only read the core
  gold dims, which is allowed across pipelines. Keep each table written by exactly one
  pipeline.
- Builds on the store-sales pivot that just landed (F004): same medallion shape, same
  `source_schema` variable, same no-join enriched pattern.

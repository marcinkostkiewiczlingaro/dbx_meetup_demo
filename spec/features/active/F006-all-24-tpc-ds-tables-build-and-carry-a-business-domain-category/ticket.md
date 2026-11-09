---
opened: 2026-11-09
---

# F006 · All 24 TPC-DS tables build, and every gold table carries a business-domain category

## Outcome

The demo now covers the whole TPC-DS schema, not a sales-only slice. The seven source
tables that no pipeline reads today — `customer_demographics`, `household_demographics`,
`income_band`, `reason`, `time_dim`, `warehouse`, `inventory` — build through bronze,
silver, and gold like the rest. This adds a second fact subject area beyond sales:
inventory, a periodic stock snapshot over item, warehouse, and date. Every gold table is
then assigned to one named business domain through a documented registry and a governed
tag on the table, so Part 2 can lift those groups straight into Databricks (Unity Catalog)
Domains without re-deciding what belongs where. The talk gains a clean "domains are a
governance layer over your tables, not the same as your pipelines" moment.

## Scope

- Add the five remaining conformed shared dimensions to the existing `core` pipeline, under
  `src/core/` (bronze → silver → gold): `dim_time` (time_dim), `dim_reason` (reason),
  `dim_customer_demographics`, `dim_household_demographics`, `dim_income_band`. The core
  pipeline globs `src/core/**`, so no resource change is needed for these. Start seam:
  mirror `src/core/.../date_dim` three-layer pattern for `time_dim`.
- Add one new `inventory` domain: `src/inventory/` with `dim_warehouse` and the
  `fct_inventory` periodic-snapshot fact (grain inv_item_sk × inv_warehouse_sk ×
  inv_date_sk), plus `resources/inventory_pipeline.yml` modeled on `core_pipeline.yml`.
- Add a domain registry, `docs/domains/README.md`, that maps every gold table (existing and
  new) to exactly one named business domain. Choose a small, defensible domain set that
  covers all gold tables (for example: Customer, Calendar, Product, Marketing, Store Sales,
  Catalog Sales, Web Sales, Inventory, Shipping & Returns Reference). Pipelines stay the
  build-ownership layer; domains are the cross-cutting governance layer.
- Carry each gold table's domain on the table itself as a governed Unity Catalog tag
  (`domain` tag). If applying tags inside a Lakeflow pipeline is not reliable, fall back to
  a `domain=<name>` line in the table COMMENT and say so in the registry; the registry stays
  the authoritative source either way.
- Document the new `inventory` module (L2) with its L3 components and L4 gold reference
  files, per `docs/engineering/documentation-standard.md`; add the five new core dims to the
  existing core L3/L4 docs.

## Out of scope

- Creating Unity Catalog Domain governance objects or moving tables between catalogs/schemas.
  This feature prepares the categorization; creating the Domain objects is a Part 2 step.
- A Metric View for inventory, or inventory analytics beyond the enriched/fact tables.
- Moving existing dimensions between pipelines, or renaming any existing gold table.
- Deploying or running the pipelines; that stays the owner's demo-time step.

## Acceptance

- Every one of the 24 TPC-DS source tables is read by exactly one bronze table; a grep for
  `${source_schema}.<table>` finds all 24 names across `src/`.
- `databricks bundle validate --target dev` passes with the new `inventory` pipeline present
  and the five new core dims owned by the `core` pipeline.
- `fct_inventory` keys join to `gold.dim_item`, `gold.dim_warehouse`, and `gold.dim_date`;
  no dimension is rebuilt in the inventory pipeline except `dim_warehouse`.
- `docs/domains/README.md` lists every gold table exactly once, each under one named domain,
  and the domain names it uses match the tag/comment written on the tables.
- Each new gold table carries its domain in a UC tag, or in its COMMENT when tags are not
  viable, consistent with the registry.
- The new `inventory` L2 module and the updated core docs follow the documentation standard
  (front-matter, inline table, blockquote; every L3 has its entities section).

## Notes

- A gold table is owned by one pipeline but belongs to one business domain; the two layers
  are intentionally independent. Keep each table written by exactly one pipeline.
- `inventory` is TPC-DS's one non-sales fact, which is why it earns its own domain and
  pipeline; the demographic and reference tables are shared dimensions, so they live in the
  shared `core` build and are grouped into domains only by the registry and tag.
- Builds on the multi-domain sales channels that landed earlier (F005), which already named
  this inventory domain and the Domain-grouping step as the next move.

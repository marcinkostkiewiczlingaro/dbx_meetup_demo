---
opened: 2026-11-16
landed: 2026-11-16
---

# F007 · Metric Views join the gold star schema and the _enriched tables are gone

## Outcome

The demo serves eleven governed Metric Views that read the gold `fct_*` and `dim_*` tables
directly, joined on their surrogate keys. The three wide `gold.*_enriched` tables disappear
from pipeline, docs, Genie, and column dictionary. An analyst and an agent read the same
eleven governed definitions; no pre-joined copy of the star schema exists to drift from it.

## Scope

- The authoritative definitions are `metric-views-source.py` in this folder: eleven Metric
  Views over `fct_store_sales`, `fct_web_sales`, `fct_catalog_sales`, `fct_store_returns`,
  `fct_web_returns`, `fct_catalog_returns`, `fct_inventory`, `dim_item`, `dim_promotion`,
  `dim_store`, `dim_customer`. All eleven are validated against the gold schema: every
  source, join key, dimension, and measure column exists.
- Rewrite `docs/reference/metrics_views/` to one file per Metric View (standard format:
  front matter, measures table, dimensions table, `## Definition` YAML, deploy block), plus
  the folder README index. Start here.
- Delete the three `gold_*_enriched.sql` pipeline files, their three `docs/reference/tables/`
  files, and their entries in `src/semantic/column_comments.sql`.
- Point the Genie space (`genie/`) at the `store_sales_metrics` Metric View, not the
  enriched table. Update every doc that names an enriched table: components `gold.md` and
  `metrics.md`, modules, domains README, tables README, the `fct_*` table docs, main README,
  and the documentation standard's examples.

## Out of scope

- No new business measures or dimensions beyond the source file.
- No change to bronze, silver, or the `fct_*`/`dim_*` gold table SQL.
- No new pipeline for the returns/inventory/dimension Metric Views; they are Unity Catalog
  objects created from their doc, like the existing ones.

## Acceptance

- `grep -rn "_enriched" src docs genie README.md` returns nothing.
- `docs/reference/metrics_views/` holds eleven view files plus a README; each file's
  `## Definition` matches `metric-views-source.py` and its `source`/`created_as` front matter
  is a `fct_*`/`dim_*` table.
- Every measure and dimension expression names a column that exists in the referenced gold
  table or its declared join.
- The c4-docs skill standard is followed: links resolve, levels are correct, one business
  term keeps one name across metric view, table doc, and Genie instructions.
- `limen picture build --strict` passes.

## Notes

- The new views join with explicit `on:` expressions, not `using` keys — this is why the
  `_enriched` work-around is retired. The owner chose this route; keep the join form from
  the source file exactly.
- Follow the c4-docs skill (`.agents/skills/c4-docs/SKILL.md`) before editing `docs/`.

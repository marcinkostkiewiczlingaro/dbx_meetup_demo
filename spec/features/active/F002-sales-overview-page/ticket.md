---
opened: 2026-11-05
---

# F002 · Analysts see bakery sales on a published AI/BI page

## Outcome

A business user opens an AI/BI dashboard (a Page) and sees bakery sales without writing
SQL: headline numbers, revenue by product, revenue by country, and the sales trend. Every
tile reads the governed Metric View from F001, so the Page shows the same numbers the
pipeline and the semantic model define. This is the Part 2 payoff: the shared foundation
reaches a non-technical audience.

## Scope

- One AI/BI (Lakeview) dashboard as a version-controlled `.lvdash.json` under `dashboards/`.
- Tiles read `workspace.gold.sales_metrics` through `MEASURE()`; no new SQL logic.
- Deploy through the Asset Bundle with a `resources.dashboards` entry; the seam is `databricks.yml` and `resources/`.
- Tiles: headline counters (total revenue, transactions, average transaction value), revenue by product, revenue by country, sales by day.

## Out of scope

- Genie space setup and Domains; separate features.
- New metrics or gold tables; the Page consumes F001 as is.
- Row-level security or sharing rules.

## Acceptance

- `databricks bundle validate` passes with the dashboard resource.
- `databricks bundle deploy` creates the dashboard in the workspace; the lakeview API returns it.
- Each tile's query resolves against `workspace.gold.sales_metrics` and returns rows.
- The dashboard file is valid JSON and lives under `dashboards/`.

## Notes

- A Metric View dataset uses `MEASURE(\`Measure Name\`)` with `GROUP BY` on dimensions.
- Dashboard needs a warehouse id; use the Serverless Starter Warehouse.

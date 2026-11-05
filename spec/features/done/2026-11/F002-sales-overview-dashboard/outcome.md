# Outcome

Business users have an AI/BI dashboard over the governed Metric View, confirmed rendering in
the workspace. The dashboard `dashboards/bakery_sales_overview.lvdash.json` version-controls
in the repo and deploys through the Asset Bundle. It has one page with six tiles — three
headline counters (total revenue, transactions, average transaction value) and three charts
(revenue by product, revenue by country, revenue by day) — all reading
`workspace.gold.sales_metrics` through `MEASURE()`. The lakeview API reports it ACTIVE
(id `01f1d95ba7b7102e87296b7589beb49b`); tile queries return rows (total revenue 66,471).

Next reader notes: each widget query must be named `main_query`, or every tile shows
"Missing query". Programmatic checks (valid JSON, deploy, API round-trip, tile SQL) did not
catch that render-only failure; a human look did. The dashboard needs a warehouse id, set in
`resources/bakery_sales_dashboard.yml`.

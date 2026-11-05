# Outcome

Business users have an AI/BI Page over the governed Metric View. The dashboard
`dashboards/bakery_sales_overview.lvdash.json` version-controls in the repo and deploys
through the Asset Bundle. It has one page with six tiles — three headline counters (total
revenue, transactions, average transaction value) and three charts (revenue by product,
revenue by country, revenue by day) — all reading `workspace.gold.sales_metrics` through
`MEASURE()`. The bundle created it in the workspace; the lakeview API reports it ACTIVE
(id `01f1d95ba7b7102e87296b7589beb49b`) and the stored definition round-trips with all four
datasets and six tiles. Every tile query returns rows (total revenue 66,471). Merge commit
`89110c4`.

Next reader notes: the dashboard needs a warehouse id, set in `resources/bakery_sales_dashboard.yml`
(the Serverless Starter Warehouse). Open the published URL to confirm the visual render; the
acceptance here is programmatic (valid JSON, deploy, API, tile queries).

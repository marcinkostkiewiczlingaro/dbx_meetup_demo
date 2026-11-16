# Outcome

The demo now serves eleven governed Metric Views that read the gold `fct_*` and `dim_*`
tables directly, joined on their surrogate keys with explicit `on:` expressions. The three
wide `gold.*_enriched` tables are gone from the pipelines, the C4 docs, the Genie space, and
the column dictionary. Each Metric View's `## Definition` block byte-matches the owner's
source notebook, and every measure and dimension names a column that exists in the gold
table or its declared join. Genie reads the `store_sales_metrics` Metric View, so analyst
answers stand on one governed definition with no pre-joined copy to drift from.

Landed by `limen land` in merge `c453eea` (worker branch
`limen/2026-11-16-f007-metric-views-join-gold-drop-e91bf22a`). Next reader: the
`## Definition` YAML in each `docs/reference/metrics_views/*.md` file is the single source a
human runs as `CREATE OR REPLACE VIEW … WITH METRICS`; there is no deploy code that extracts
it yet. The join form was not run against Databricks Free Edition — the owner chose the
`joins:`/`on:` route, which replaces the old `_enriched` work-around.

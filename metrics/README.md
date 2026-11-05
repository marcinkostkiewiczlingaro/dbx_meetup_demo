# Metric View

`store_sales_metric_view.yml` defines the governed bakery-sales metrics once. Genie and
BI tools read these measure names, so a number always traces back to one definition.

The Asset Bundle deploys the pipeline, not the Metric View. A Metric View is a Unity
Catalog object; create it from the YAML with one SQL statement after the gold tables
exist:

```sql
CREATE OR REPLACE VIEW workspace.gold.sales_metrics
WITH METRICS
LANGUAGE YAML
AS $$
-- paste the contents of store_sales_metric_view.yml here
$$;
```

Query it with `MEASURE()`:

```sql
SELECT `Product`, MEASURE(`Total Revenue`), MEASURE(`Transaction Count`)
FROM workspace.gold.sales_metrics
GROUP BY `Product`
ORDER BY 2 DESC;
```

Note: the source is `workspace.gold.sales_enriched`, the wide gold table. Metric View
joins with `using` keys hit an engine error on Free Edition, so the fact is pre-widened
and the Metric View uses no joins.

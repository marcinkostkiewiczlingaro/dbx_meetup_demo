# Outcome

The bakery-sales medallion runs end to end in the Free Edition workspace. The Lakeflow
pipeline `bakehouse_sales_medallion` ingests `samples.bakehouse` and builds `bronze`,
`silver`, and `gold` schemas under the `workspace` catalog; all 3,333 sales flow through
and every flow completed. Gold holds a conformed star (`fct_sales` plus customer,
franchise, product, and date dimensions) and a wide `sales_enriched` table. A governed
Metric View, `workspace.gold.sales_metrics`, was created from the YAML and returns correct
numbers through `MEASURE()`. The C4, ontology, and semantic-model docs name the same terms
as the code. Merge commit `4040a7a` (final of four F001 commits from `29f4322`).

Next reader notes: the source is the public `samples.bakehouse` sample. The Metric View
uses no joins because `using`-key joins hit a Free Edition engine error; the fact is
pre-widened in `sales_enriched` instead. Card numbers stop at bronze; email and phone stop
at silver.

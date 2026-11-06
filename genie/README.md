# Genie Space

`store_sales_space.json` is the version-controlled definition of the Genie space. It wires
Genie to `workspace.gold.store_sales_enriched` — the governed gold table the Metric View
also reads — and carries the shared vocabulary as text instructions, so Genie's answers
match the dashboards and the metrics.

The Asset Bundle does not deploy Genie spaces. Create the space from the JSON with the Genie
API after the gold tables exist:

```bash
databricks genie create-space 8c378844e8d9cadf "$(cat genie/store_sales_space.json)" \
  --title "Store Sales" \
  --description "Ask store sales questions in natural language, on the governed gold model."
```

Ask a question against the space (space-scoped, uses its tables and instructions):

```bash
databricks genie start-conversation <space_id> "What is the net sales, and the top category by net sales?"
```

Notes:
- Serialized space schema is version 2. Tables go in `data_sources.tables[].identifier`;
  instructions go in `instructions.text_instructions[].content[]` as an array of strings.
- `genie ask` is space-less; use `start-conversation` to exercise this space.
- The measure and dimension names in the instructions match the Metric View
  (`docs/reference/metrics_views/store_sales_metrics.md`) and the ontology — one name for
  one thing.

# Genie Space

`bakery_sales_space.json` is the version-controlled definition of the Genie space. It wires
Genie to `workspace.gold.sales_enriched` — the governed gold table the Metric View also
reads — and carries the semantic model as text instructions, so Genie's answers match the
dashboards and the metrics.

The Asset Bundle does not deploy Genie spaces. Create the space from the JSON with the
Genie API after the gold tables exist:

```bash
databricks genie create-space 8c378844e8d9cadf "$(cat genie/bakery_sales_space.json)" \
  --title "Bakery Sales" \
  --description "Ask bakery sales questions in natural language, on the governed gold model."
```

Ask a question against the space (space-scoped, uses its tables and instructions):

```bash
databricks genie start-conversation <space_id> "What is the total revenue, and the top product by revenue?"
```

Notes:
- Serialized space schema is version 2. Tables go in `data_sources.tables[].identifier`;
  instructions go in `instructions.text_instructions[].content[]` as an array of strings.
- `genie ask` is space-less; use `start-conversation` to exercise this space.
- Sample questions are not in the serialized schema; add them in the UI if wanted.

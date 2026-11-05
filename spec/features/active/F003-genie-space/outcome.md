# Outcome

Analysts can ask bakery sales questions in natural language through a Genie space, proven
live in the workspace. The space "Bakery Sales" (id `01f1d95d34801550a076d05d60e5bd69`) is
wired to `workspace.gold.sales_enriched` and carries the semantic model as text
instructions. A question — "total revenue, and the top product by revenue" — returned total
revenue 66,471 and Golden Gate Ginger (11,595), matching the Metric View and the AI/BI Page.
The serialized space version-controls in `genie/bakery_sales_space.json` with a recreate
guide. Merge commit will follow this file.

Next reader notes: the serialized space schema is version 2 — tables in
`data_sources.tables[].identifier`, instructions in `instructions.text_instructions[].content[]`
(array of strings). The Asset Bundle does not deploy Genie spaces; create with
`databricks genie create-space`. `genie ask` is space-less; use `genie start-conversation`
to exercise the space. Sample questions are UI-only, not in the serialized schema.

---
opened: 2026-11-05
---

# F003 · Analysts ask bakery sales questions in natural language through Genie

## Outcome

A business user opens a Genie space and asks a sales question in plain English. Genie
answers from the governed gold table, using instructions that carry the semantic model, so
its numbers match the Metric View and the AI/BI Page. This is the natural-language side of
Part 2: the same foundation, now reachable without SQL.

## Scope

- One Genie space wired to `workspace.gold.sales_enriched`, the governed gold table that
  the Metric View also reads.
- Text instructions that encode the semantic model: metric definitions, business terms,
  known products and payment methods.
- A version-controlled serialized space (`genie/bakery_sales_space.json`) and a recreate
  guide; the seam is `genie/`.

## Out of scope

- Databricks Domains (UI-only in Free Edition).
- Changing gold tables or the Metric View; Genie consumes them as is.
- Genie benchmark or evaluation runs.

## Acceptance

- The space exists in the workspace and lists `workspace.gold.sales_enriched` as its data.
- A natural-language question ("total revenue, top product") returns numbers that match the
  Metric View (total revenue 66,471; top product Golden Gate Ginger).
- The serialized space is valid JSON and recreates the space through the Genie API.

## Notes

- The serialized space schema is version 2: `data_sources.tables[].identifier` and
  `instructions.text_instructions[].content[]` (an array of strings). Sample questions are
  not part of this schema; add them in the UI if wanted.
- `databricks genie start-conversation <space_id> "<question>"` runs a question against the
  space (space-scoped), unlike `genie ask`, which is space-less.

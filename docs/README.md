# Documentation

Three linked views of the same bakery-sales slice. They describe one foundation, so an
AI agent or a reader reaches code, data, and business meaning from any entry point.

| View | Question it answers | Location |
|---|---|---|
| C4 architecture | How does the system fit together? | `architecture/c4/` |
| Ontology | What are the business objects and how do they link? | `ontology/` |
| Semantic model | What does each metric mean and where does it come from? | `semantic/` |

## How they connect

```
bakehouse sample  ─▶  src/ pipeline  ─▶  bronze ▸ silver ▸ gold (Unity Catalog)
                                                   │
                      ontology (objects, links) ◀──┤
                      semantic model (metrics)  ◀──┤
                      Metric View (metrics/)    ◀──┘  ─▶  AI/BI Page, Genie
```

The through-line: one business term keeps one name across the silver columns, the gold
star schema, the ontology, the semantic model, and the Metric View.

## Repository layout

- `databricks.yml`, `resources/` — Databricks Asset Bundle and the Lakeflow pipeline.
- `src/bronze`, `src/silver`, `src/gold` — one SQL file per table, by medallion layer.
- `metrics/` — the governed Metric View.
- `dashboards/` — the AI/BI Page (`.lvdash.json`), deployed by the bundle.
- `genie/` — the Genie space definition and recreate guide.
- `docs/` — these three views.
- `spec/` — vision, styleguide, and feature tickets for the agent workflow.

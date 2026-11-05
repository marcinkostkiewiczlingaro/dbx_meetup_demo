# Vision

> Human-owned durable intent for every role. Keep this file at or below 1000 lines. The injected copy is capped at 1000 lines; keep each item high-signal and move supporting history to feature notes. The coordinator may propose changes but does not invent or rewrite this intent unprompted.

## Product principles

- This is a demo for a meetup talk: "Give AI a Brain. Building a Shared Semantic Foundation for AI Agents and Databricks Genie." Every artifact must read clearly on a slide or in a live walk-through.
- One semantic foundation serves both audiences. AI for data engineers and AI for data analysts must share the same understanding of the data platform; two separate models of the same data is the failure we are showing how to avoid.
- Context beats prompts. The value is in structured, governed knowledge behind the model — architecture docs, C4 models, code-derived lineage, ontology, coding standards — not in a cleverer prompt or a bigger model.
- Knowledge connects code, data, and business meaning. A term means the same thing to the pipeline, to the metric, and to the analyst asking Genie.
- Trusted and explainable over clever. Business definitions and metrics the answer stands on must be visible and governed, so an answer can be traced back to its source.
- Show, do not tell. Prefer a working Databricks example — Unity Catalog, Metric Views, Domains, Genie — over prose about what could be done.

## Current direction

- Part 1 — AI for Data Engineers: turn an existing Databricks project into an AI-ready development environment. Demonstrate architecture documentation, C4 models, code-derived data lineage, an ontology, coding standards, and an agent-driven workflow (such as BMAD) that helps agents navigate pipelines and implement features consistently.
- Part 2 — AI for Data Analysts: carry the same knowledge into Databricks' semantic layer — Unity Catalog, Metric Views, Domains, Pages, Genie Ontology, Genie One, and Genie Code — so Genie gives accurate, consistent, explainable answers.
- Near-term priority: build the shared semantic foundation first, then show each side consuming it. The connection between the two parts is the point of the talk, not an afterthought.

# Styleguide

> Project-owned coding practice for every coordinator, worker, and reviewer turn. Keep this file at or below 1000 lines. The injected copy is capped at 1000 lines. Edit this file to change how agents write and organize code here. It is not product scope and not speech.

## Shape

- This is a Databricks demo. Keep each artifact small enough to show on a slide or walk through live: short notebooks, short SQL files, short config.
- One concept per file. A table definition, a metric view, a pipeline step, or an ontology term each lives in its own file, named for the concept.
- Separate the three layers so the semantic foundation stays visible: raw/source, transformation (pipeline code), and semantic (Unity Catalog objects, Metric Views, ontology). Do not mix a business definition into a transformation step.
- Keep architecture docs (C4 models, lineage, ontology) beside the code they describe, in Markdown or a declared format, so an agent finds them without a tour.

## Prefer

- Declarative over imperative: define tables, metrics, and relationships as data or SQL, not as procedural code, so both agents and Genie can read them.
- One name for one thing. A business term has a single spelling across code, Unity Catalog, Metric Views, and the ontology. Reuse the canonical name; do not coin a synonym.
- Explicit, governed definitions. A metric or business term carries its definition and source where it is declared, so an answer can be traced back.
- Fully qualified Unity Catalog names (`catalog.schema.object`) in SQL and configuration.
- Comments and docstrings that state business meaning and the source of truth, not what the code line does.

## Avoid

- Two definitions of the same metric or term. If engineering and analytics would describe it differently, that is the problem the demo exists to fix — unify it.
- Hardcoded paths, credentials, or workspace IDs in code. Use configuration or Databricks secrets.
- Undeclared magic in notebooks: hidden state between cells, `%run` chains that hide lineage, or results that depend on run order.
- Transformation logic buried inside a semantic object, or a business definition buried inside a transformation. Keep the layer boundary clean.
- Large, multi-purpose files that cannot be read in one pass during the talk.

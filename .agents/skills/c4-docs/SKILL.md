---
name: c4-docs
description: How to read and write this project's C4 documentation under docs/. Use before adding or changing any file under docs/ — a table reference, a metric view, an algorithm, a component, a module, the ontology object graph, or the documentation standard itself.
---

# C4 documentation

The single source of truth is [`docs/engineering/documentation-standard.md`](../../../docs/engineering/documentation-standard.md). Read it before you touch `docs/`, and follow it. This skill only routes you there and names the rules that are easy to break; it never restates the standard.

## Before you edit

1. Open `docs/engineering/documentation-standard.md`.
2. Find the "Adding a New ..." section for what you are creating and follow its numbered steps.
3. Match the layout of a sibling file at the same C4 level.

## Invariants the standard enforces (check, do not re-specify)

- **One navigation element per file**, directly under the title — the inline metadata table (L2–L4 content files) or a breadcrumb (L1 and index files). Never a `## Navigation` section, never at the bottom.
- **Every L3 component file has an `## Entities` table**, and every entity named in front-matter is defined there.
- **The ontology is not a folder.** A business object is its gold table's L4 file: it carries `object_type`, `primary_key`, `source_of_truth`, a `Source column` in `## Columns`, and a `## Links` section. Do not create an `ontology/` folder.
- **One name for one thing.** An object type, a property, a measure, and a dimension are spelled the same in the table file, the Metric View, the Genie space, and the dashboard.
- **Diagrams use mermaid C4 types** (`C4Context`, `C4Container`, `C4Component`). The one exception is the ontology object graph at L2 in `docs/modules/README.md`, which uses `erDiagram`. Never a generic `flowchart`/`graph`.
- **L4 types:** `table_schema`, `metric_view`, `algorithm`. A Metric View's YAML lives only in its `## Definition` block — never a second copy.
- **Every gold table carries one `domain`.** The subdomain `tag_key` (for example `Retail Analytics/Sales`) is spelled the same in four places: the registry (`docs/domains/README.md`), the L4 front-matter `domain` field, the `Business domain:` prose, and the on-table `COMMENT` `domain=<tag_key>` marker in the pipeline SQL. The field is L4 only — an L3 gold component crosses subdomains, so it never carries one `domain`.

## Databricks Domains are the source of the domain tree

The domain tree is governed in the Databricks workspace, not invented in the docs. Confirm it, then follow it, before you change any subdomain:

- List the live tree with the Databricks CLI: `databricks api get /api/2.0/domains -p free` (the documented path `/api/domains/v1/domain` returns Not Found; `/api/2.0/domains` is the working REST path). Reference: <https://docs.databricks.com/api/domains/v1/domain>.
- Each domain returns a `tag_key` (`Parent/Child` for a subdomain), a `domain_id`, and a `parent_domain_id`. The `tag_key` is the one canonical name — it is the Unity Catalog tag the Domain applies to a table. Ignore the Databricks-managed `system.general_domain`.
- The registry (`docs/domains/README.md`) records each domain's `tag_key` and `domain_id` from this API and maps every gold table to exactly one subdomain. Follow "Adding or Changing a Domain" in the standard to keep the four copies above in sync.

## After you edit

- Register the new file in its index (`docs/modules/README.md`, `docs/components/README.md`, or the matching `reference/*/README.md`).
- Check that every relative link resolves.

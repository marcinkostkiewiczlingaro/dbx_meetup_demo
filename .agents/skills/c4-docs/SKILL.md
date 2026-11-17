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
- **Diagrams use mermaid C4 types** (`C4Context`, `C4Container`, `C4Component`). The one exception is the ontology object graph in `docs/reference/tables/README.md` (the object types are the gold tables, so the semantic graph lives with them, not in the build-view `docs/modules/README.md`), which uses `erDiagram`. Never a generic `flowchart`/`graph`.
- **L4 types:** `table_schema`, `metric_view`, `algorithm`, `page`. A Metric View's YAML lives only in its `## Definition` block — never a second copy. A `page` (Genie knowledge page) is the business-term layer over a Metric View measure or dimension: it carries the definition and synonyms, never the measure expression as authority, and is spelled the same as the measure and gold column. Links are reciprocal — a page's inline-table `metric views` column and each view's/component's `## Pages`.
- **Every gold table and every Metric View carries one `domain`.** The subdomain `tag_key` (for example `Retail Analytics/Sales`) is spelled the same in the registry (`docs/domains/README.md`), the L4 front-matter `domain` field, the prose, and the on-object copy. The on-object copy differs by object: a gold table carries a `COMMENT` `domain=<tag_key>` marker (pipelines cannot set UC tags reliably); a Metric View carries a real UC tag the Genie Domain applies (tag name = `tag_key`, empty value), and its subdomain is that of the gold table it reads. The field is L4 only — an L3 gold component crosses subdomains, so it never carries one `domain`.

## Databricks Domains are the source of the domain tree

The domain tree is governed in the Databricks workspace, not invented in the docs. Confirm it, then follow it, before you change any subdomain:

- List the live tree with the Databricks CLI: `databricks api get /api/2.0/domains -p free` (the documented path `/api/domains/v1/domain` returns Not Found; `/api/2.0/domains` is the working REST path). Reference: <https://docs.databricks.com/api/domains/v1/domain>.
- Each domain returns a `tag_key` (`Parent/Child` for a subdomain), a `domain_id`, and a `parent_domain_id`. The `tag_key` is the one canonical name — it is the Unity Catalog tag the Domain applies to a table. Ignore the Databricks-managed `system.general_domain`.
- The registry (`docs/domains/README.md`) records each domain's `tag_key` and `domain_id` from this API and maps every gold table to exactly one subdomain. Follow "Adding or Changing a Domain" in the standard to keep the four copies above in sync.

## Databricks Knowledge Pages are the source of the page files

A page file under `docs/reference/pages/` mirrors a Genie **Knowledge Page** governed in the workspace. Confirm the live page, then document it:

- List the live pages with the Databricks CLI: `databricks api get /api/2.0/knowledge/pages -p free`, and read one with `databricks api get /api/2.0/knowledge/pages/<page_id> -p free` (the documented path `/api/knowledge/v1/page` is the reference, not the REST route; `/api/2.0/knowledge/pages` is the working path). Reference: <https://docs.databricks.com/api/knowledge/v1/page>.
- The list returns a summary (`name`, `domain`, `display_name`, `state`, `update_time`); the per-page get adds `description`, `body` (markdown: Definition, Business use, Examples), and `synonyms`. The `name` is `pages/<uuid>`; the uuid is the `page_id`. `domain` is `domains/<domain_id>` from the Domains API.
- A page names a measure or dimension that already lives in a Metric View. The page is the business-term layer; the Metric View file stays the source of truth for the expression and YAML. Follow "Adding a New Page Reference File" in the standard, and keep the links reciprocal (a page's inline-table `metric views` column, each view's and component's `## Pages`).

## After you edit

- Register the new file in its index (`docs/modules/README.md`, `docs/components/README.md`, or the matching `reference/*/README.md`).
- Check that every relative link resolves.

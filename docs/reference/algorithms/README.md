# Algorithms (L4 — Code)

↑ [System Context](../../README.md) &nbsp;|&nbsp; ← [Metric Views](../metrics_views/README.md)

> **C4 Level 4 — Algorithms.** One file per named computation or business-logic algorithm —
> an allocation, a weighting, a de-duplication, a non-trivial derivation — so a number can be
> traced back to its rule without reading the code.

An algorithm reference file documents one computation that a column name alone does not
explain. It describes the rule in business terms and links to the code that runs it
(`implemented_in`); it never holds a second copy of the executable logic. An entity that uses
an algorithm links to its file from the `Algorithm(s)` column of its `## Entities` table.

**This demo has no algorithms yet.** Every entity's logic today is a plain column mapping, so
the `Algorithm(s)` column is `—` everywhere and this folder holds only this index. The type
exists so the first real computation has a governed home instead of hiding inside a SQL file.
See [Adding a New Algorithm Reference File](../../engineering/documentation-standard.md#adding-a-new-algorithm-reference-file).

| Algorithm | Computes | Implemented in |
|---|---|---|
| _(none yet)_ | | |

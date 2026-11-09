# F006 · Outcome

All 24 TPC-DS source tables now build through bronze, silver, and gold. The seven that no
pipeline read before — `time_dim`, `reason`, `customer_demographics`,
`household_demographics`, `income_band` (added to the shared `core` pipeline) and
`warehouse` + `inventory` (a new `inventory` pipeline) — complete the schema. Inventory is
the demo's first non-sales fact: a periodic stock snapshot at grain item × warehouse × date.

Every gold table (26) carries its business domain as a `domain=<Name>` marker in its table
COMMENT, grouped into nine domains: Customer, Calendar, Product, Marketing, Store Sales,
Catalog Sales, Web Sales, Inventory, and Shipping & Returns Reference. `docs/domains/README.md`
is the authoritative registry and lists every gold table exactly once; the per-domain counts
equal the on-table markers. Pipelines stay the build layer; domains sit on top as a governance
layer, ready for Part 2 to lift straight into Unity Catalog Domain objects.

Landed on main in merge `673decd` (work commits `60e4236` SQL + registry, `330ec37` docs).
`databricks bundle validate --target dev` passed with the inventory pipeline registered.

Design note: the domain is carried in the table COMMENT, not a Unity Catalog tag, because
`ALTER TABLE ... SET TAGS` is not part of a Lakeflow `CREATE OR REFRESH` definition and
in-pipeline UC tagging is not reliable. The ticket allowed this fallback; the registry stays
authoritative. Applying real UC tags is a Part-2 post-deploy step.

Not verified by a live run: the pipelines were not deployed or executed, so column types and
join results were checked by inspection and `bundle validate`, not by a pipeline run. Running
the pipelines is the owner's demo-time step.

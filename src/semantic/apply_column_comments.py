# Databricks notebook source
# Applies the governed column dictionary (src/semantic/column_comments.sql) to Unity Catalog.
# Run as the last task of the build job, after the pipelines create the tables.
# Lakeflow does not carry inline column comments into UC, so the dictionary is applied here
# with COMMENT ON COLUMN, which survives a pipeline full refresh.
import time

dbutils.widgets.text("comments_file", "")
path = dbutils.widgets.get("comments_file")
if not path:
    raise ValueError("comments_file parameter is required (path to column_comments.sql)")

text = open(path, "r").read()
stmts = [ln.strip().rstrip(";") for ln in text.splitlines()
         if ln.strip().startswith("COMMENT ON COLUMN")]
print(f"applying {len(stmts)} column comments from {path}")

fails = []
for i, sql in enumerate(stmts, 1):
    for attempt in range(6):
        try:
            spark.sql(sql)
            break
        except Exception as e:  # noqa: BLE001
            msg = str(e)
            transient = "CONCURRENT" in msg or "PARTIAL_FAILURE" in msg
            if transient and attempt < 5:
                time.sleep(2 * (attempt + 1))
                continue
            fails.append((sql, msg))
            break
    if i % 100 == 0:
        print(f"  {i}/{len(stmts)}")

print(f"done. applied {len(stmts) - len(fails)}, failures {len(fails)}")
for sql, msg in fails[:20]:
    print("FAIL", sql[:90], "|", msg[:140])
if fails:
    raise Exception(f"{len(fails)} column comments failed")

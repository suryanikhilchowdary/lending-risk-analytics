"""
Export the dbt marts from DuckDB to CSVs for Power BI.
Run AFTER `dbt run`.

Usage:
    python export_marts.py
"""
import duckdb, os

MARTS = ["mart_default_by_segment", "mart_rate_vs_risk", "mart_credit_policy"]
os.makedirs("powerbi/data", exist_ok=True)

con = duckdb.connect("lending.duckdb")
for m in MARTS:
    con.execute(f"COPY main.{m} TO 'powerbi/data/{m}.csv' (HEADER, DELIMITER ',')")
    print(f"exported powerbi/data/{m}.csv")

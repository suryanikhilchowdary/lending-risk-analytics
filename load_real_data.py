"""
Load LendingClub loan_data.csv into DuckDB as raw.loans.
Handles the file's old-Mac (\r) line endings automatically.

Usage:
    python load_real_data.py path/to/loan_data.csv
"""
import duckdb, sys, os

CSV = sys.argv[1] if len(sys.argv) > 1 else "loan_data.csv"
if not os.path.exists(CSV):
    sys.exit(f"File not found: {CSV}")

# Normalise line endings to \n so the CSV parser reads rows correctly
with open(CSV, "rb") as f:
    data = f.read().replace(b"\r\n", b"\n").replace(b"\r", b"\n")
clean = CSV + ".clean"
with open(clean, "wb") as f:
    f.write(data)

con = duckdb.connect("lending.duckdb")
con.execute("CREATE SCHEMA IF NOT EXISTS raw")
con.execute(f"""
    CREATE OR REPLACE TABLE raw.loans AS
    SELECT * FROM read_csv_auto('{clean}', header=true)
""")
n = con.execute("SELECT count(*) FROM raw.loans").fetchone()[0]
os.remove(clean)
print(f"Loaded {n:,} rows into raw.loans")

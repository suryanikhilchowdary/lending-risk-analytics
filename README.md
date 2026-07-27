# LendingClub Risk & Portfolio Analytics

End-to-end analytics-engineering project on ~9,600 LendingClub loans:
raw CSV -> dbt models on DuckDB (tested) -> Power BI dashboard.

## Business questions & headline findings
1. **What drives default?** FICO is the dominant driver — default climbs from
   8% (740+) to 31% (<660). Small-business loans default at 28% vs 11% for
   major purchases.
2. **Are segments priced for their risk?** The <660 band defaults at 31% but is
   only charged ~15% — a 15.7-point risk-vs-price gap. Sub-700 borrowers are
   systematically underpriced.
3. **How well does the credit policy screen risk?** Loans that fail LendingClub's
   underwriting criteria default at 27.8% vs 13.2% for those that pass.
4. **Recommendation:** tighten pricing / approval on sub-700 FICO, especially
   small-business purpose.

## Stack
DuckDB (warehouse) · dbt (staging -> marts, 7 tests) · Power BI (dashboard)

## Run it
```bash
pip install dbt-duckdb duckdb
python load_real_data.py loan_data.csv     # loads raw.loans (handles \r line endings)
export DBT_PROFILES_DIR=$(pwd)
dbt run && dbt test            # builds + tests the marts in DuckDB
python export_marts.py         # writes the 3 mart CSVs to powerbi/data/
```

## Structure
- `models/staging/stg_loans.sql` — cleans dotted column names, derives FICO bands + target
- `models/marts/` — three analytical tables, one per business question
- `powerbi/data/` — mart CSVs, ready to import into Power BI
- `load_real_data.py` — loads the raw CSV into DuckDB


  
    
    

    create  table
      "lending"."main"."mart_rate_vs_risk__dbt_tmp"
  
    as (
      -- Q2: Are segments priced for their risk? Compare rate charged to realized default.
-- risk_gap > 0 flags segments where default outpaces what the rate spread covers.
select
    fico_band,
    count(*)                                        as loans,
    round(avg(interest_rate) * 100, 2)              as avg_rate_pct,
    round(100.0 * sum(is_default) / count(*), 1)    as default_rate_pct,
    round(100.0 * sum(is_default) / count(*)
          - avg(interest_rate) * 100, 1)            as risk_minus_rate_pct
from "lending"."main"."stg_loans"
group by fico_band
order by fico_band
    );
  
  
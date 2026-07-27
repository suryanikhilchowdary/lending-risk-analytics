-- Q1: What drives default? Default rate by purpose and FICO band.
select
    purpose,
    fico_band,
    count(*)                                       as loans,
    sum(is_default)                                as defaults,
    round(100.0 * sum(is_default) / count(*), 1)   as default_rate_pct,
    round(avg(interest_rate) * 100, 2)             as avg_rate_pct,
    round(avg(dti), 1)                             as avg_dti,
    round(avg(revolving_utilization), 1)           as avg_revol_util
from "lending"."main"."stg_loans"
group by purpose, fico_band
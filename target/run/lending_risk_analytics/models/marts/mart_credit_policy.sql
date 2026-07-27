
  
    
    

    create  table
      "lending"."main"."mart_credit_policy__dbt_tmp"
  
    as (
      -- Q4: How well does LendingClub's credit policy screen out risk?
select
    case when meets_credit_policy = 1 then 'Passed policy' else 'Failed policy' end as policy_status,
    count(*)                                        as loans,
    sum(is_default)                                 as defaults,
    round(100.0 * sum(is_default) / count(*), 1)    as default_rate_pct,
    round(avg(fico), 0)                             as avg_fico,
    round(avg(interest_rate) * 100, 2)              as avg_rate_pct
from "lending"."main"."stg_loans"
group by 1
    );
  
  
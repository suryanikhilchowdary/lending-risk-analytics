
  
  create view "lending"."main"."stg_loans__dbt_tmp" as (
    -- Clean & enrich the raw LendingClub loans.
-- Renames dotted columns, derives target + risk bands used downstream.
with source as (
    select * from "lending"."raw"."loans"
)
select
    row_number() over ()                        as loan_id,
    "credit.policy"                             as meets_credit_policy,   -- 1 = passed LC underwriting
    purpose,
    "int.rate"                                  as interest_rate,
    installment,
    "log.annual.inc"                            as log_annual_income,
    round(exp("log.annual.inc"), 0)             as annual_income,          -- back out actual $
    dti,
    fico,
    case
        when fico < 660 then '<660'
        when fico < 700 then '660-699'
        when fico < 740 then '700-739'
        else '740+'
    end                                          as fico_band,
    "days.with.cr.line"                         as days_with_credit_line,
    "revol.bal"                                 as revolving_balance,
    "revol.util"                                as revolving_utilization,
    "inq.last.6mths"                            as inquiries_6mo,
    "delinq.2yrs"                               as delinquencies_2yr,
    "pub.rec"                                   as public_records,
    "not.fully.paid"                            as is_default            -- 1 = not fully paid (loss proxy)
from source
  );

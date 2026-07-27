
    
    

with all_values as (

    select
        meets_credit_policy as value_field,
        count(*) as n_records

    from "lending"."main"."stg_loans"
    group by meets_credit_policy

)

select *
from all_values
where value_field not in (
    '0','1'
)



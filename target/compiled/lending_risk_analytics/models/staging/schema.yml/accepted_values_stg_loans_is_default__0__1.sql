
    
    

with all_values as (

    select
        is_default as value_field,
        count(*) as n_records

    from "lending"."main"."stg_loans"
    group by is_default

)

select *
from all_values
where value_field not in (
    '0','1'
)



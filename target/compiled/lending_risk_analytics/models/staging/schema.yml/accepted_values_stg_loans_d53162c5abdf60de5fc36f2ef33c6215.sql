
    
    

with all_values as (

    select
        fico_band as value_field,
        count(*) as n_records

    from "lending"."main"."stg_loans"
    group by fico_band

)

select *
from all_values
where value_field not in (
    '<660','660-699','700-739','740+'
)



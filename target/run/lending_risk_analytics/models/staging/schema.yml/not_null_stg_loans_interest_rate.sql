
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select interest_rate
from "lending"."main"."stg_loans"
where interest_rate is null



  
  
      
    ) dbt_internal_test
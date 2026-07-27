
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_default
from "lending"."main"."stg_loans"
where is_default is null



  
  
      
    ) dbt_internal_test
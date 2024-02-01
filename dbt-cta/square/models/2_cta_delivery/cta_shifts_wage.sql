{{ config(full_refresh=false) }}
select *
from {{ source('cta','shifts_wage_base') }}

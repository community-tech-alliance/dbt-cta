{{ config(full_refresh=false) }}
select *
from {{ source('cta','categories_base') }}

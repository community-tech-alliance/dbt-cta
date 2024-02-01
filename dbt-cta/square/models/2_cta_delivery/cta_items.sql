{{ config(full_refresh=false) }}
select *
from {{ source('cta','items_base') }}

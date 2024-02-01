{{ config(full_refresh=false) }}
select *
from {{ source('cta','modifier_list_base') }}

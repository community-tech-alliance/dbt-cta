{{ config(full_refresh=false) }}
select *
from {{ source('cta','payments_base') }}

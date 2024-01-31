{{ config(full_refresh=false) }}
select *
from {{ source('cta','refunds_base') }}

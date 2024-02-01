{{ config(full_refresh=false) }}
select *
from {{ source('cta','taxes_base') }}

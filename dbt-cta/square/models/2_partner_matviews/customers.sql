{{ config(full_refresh=false) }}
select *
from {{ source('cta','customers_base') }}

{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_taxes_base') }}

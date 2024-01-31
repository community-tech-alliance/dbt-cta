{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_refunds_base') }}

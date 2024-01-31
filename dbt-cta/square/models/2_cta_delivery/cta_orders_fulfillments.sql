{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_fulfillments_base') }}

{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_net_amounts_base') }}
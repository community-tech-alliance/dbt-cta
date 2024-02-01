{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_net_amounts_total_money_base') }}

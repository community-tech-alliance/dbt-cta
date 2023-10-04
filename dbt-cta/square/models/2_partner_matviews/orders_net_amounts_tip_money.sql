{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_net_amounts_tip_money_base') }}

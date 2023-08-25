{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_net_amounts_service_charge_money_base') }}

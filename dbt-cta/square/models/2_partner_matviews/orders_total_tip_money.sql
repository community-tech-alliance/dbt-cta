{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_total_tip_money_base') }}

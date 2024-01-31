{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_total_money_base') }}

{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_return_amounts_discount_money_base') }}

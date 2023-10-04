{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_refunds_amount_money_base') }}

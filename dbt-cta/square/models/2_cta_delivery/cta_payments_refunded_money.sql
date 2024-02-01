{{ config(full_refresh=false) }}
select *
from {{ source('cta','payments_refunded_money_base') }}

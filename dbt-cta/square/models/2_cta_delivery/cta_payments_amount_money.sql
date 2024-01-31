{{ config(full_refresh=false) }}
select *
from {{ source('cta','payments_amount_money_base') }}

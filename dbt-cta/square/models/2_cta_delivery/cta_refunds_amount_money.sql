{{ config(full_refresh=false) }}
select *
from {{ source('cta','refunds_amount_money_base') }}

{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_tenders_amount_money_base') }}

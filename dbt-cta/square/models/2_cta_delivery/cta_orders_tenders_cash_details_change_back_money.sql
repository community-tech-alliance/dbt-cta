{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_tenders_cash_details_change_back_money_base') }}

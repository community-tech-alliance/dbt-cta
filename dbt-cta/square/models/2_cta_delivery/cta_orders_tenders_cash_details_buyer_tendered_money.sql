{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_tenders_cash_details_buyer_tendered_money_base') }}

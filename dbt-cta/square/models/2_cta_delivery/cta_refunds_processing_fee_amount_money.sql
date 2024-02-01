{{ config(full_refresh=false) }}
select *
from {{ source('cta','refunds_processing_fee_amount_money_base') }}

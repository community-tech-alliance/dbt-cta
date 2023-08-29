{{ config(full_refresh=false) }}
select *
from {{ source('cta','refunds_processing_fee_base') }}

select *
from {{ source('cta','refunds_processing_fee_base') }}

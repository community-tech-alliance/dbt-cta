select *
from {{ source('cta','payments_processing_fee_base') }}

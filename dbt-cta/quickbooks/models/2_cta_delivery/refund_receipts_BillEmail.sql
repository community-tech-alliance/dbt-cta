select
    _airbyte_refund_receipts_hashid,
    Address,
    _airbyte_extracted_at,
    _airbyte_BillEmail_hashid
from {{ source('cta','refund_receipts_BillEmail_base') }}

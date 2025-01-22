select
    _airbyte_refund_receipts_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','refund_receipts_CustomerRef_base') }}

select
    _airbyte_refund_receipts_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_CustomerMemo_hashid
from {{ source('cta','refund_receipts_CustomerMemo_base') }}

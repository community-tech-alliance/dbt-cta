select
    _airbyte_refund_receipts_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','refund_receipts_CurrencyRef_base') }}

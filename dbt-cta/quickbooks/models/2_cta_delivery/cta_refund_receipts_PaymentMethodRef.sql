select
    _airbyte_refund_receipts_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_PaymentMethodRef_hashid
from {{ source('cta','refund_receipts_PaymentMethodRef_base') }}

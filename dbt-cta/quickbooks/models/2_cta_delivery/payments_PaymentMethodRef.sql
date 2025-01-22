select
    _airbyte_payments_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_PaymentMethodRef_hashid
from {{ source('cta','payments_PaymentMethodRef_base') }}

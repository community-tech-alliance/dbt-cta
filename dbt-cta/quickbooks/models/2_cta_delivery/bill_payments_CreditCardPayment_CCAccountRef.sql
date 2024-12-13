select
    _airbyte_CreditCardPayment_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CCAccountRef_hashid
from {{ source('cta','bill_payments_CreditCardPayment_CCAccountRef_base') }}

select
    _airbyte_bill_payments_hashid,
    CCAccountRef,
    _airbyte_emitted_at,
    _airbyte_CreditCardPayment_hashid
from {{ source('cta','bill_payments_CreditCardPayment_base') }}
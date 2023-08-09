select
    _airbyte_bill_payments_hashid,
    PrintStatus,
    BankAccountRef,
    _airbyte_emitted_at,
    _airbyte_CheckPayment_hashid
from {{ source('cta','bill_payments_CheckPayment_base') }}
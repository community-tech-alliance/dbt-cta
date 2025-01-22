select
    _airbyte_CheckPayment_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_BankAccountRef_hashid
from {{ source('cta','bill_payments_CheckPayment_BankAccountRef_base') }}

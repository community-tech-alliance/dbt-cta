select
    _airbyte_DepositLineDetail_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_PaymentMethodRef_hashid
from {{ source('cta','deposits_Line_DepositLineDetail_PaymentMethodRef_base') }}
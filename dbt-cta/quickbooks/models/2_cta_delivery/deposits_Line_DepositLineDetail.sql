select
    _airbyte_Line_hashid,
    PaymentMethodRef,
    AccountRef,
    CheckNum,
    _airbyte_extracted_at,
    _airbyte_DepositLineDetail_hashid
from {{ source('cta','deposits_Line_DepositLineDetail_base') }}

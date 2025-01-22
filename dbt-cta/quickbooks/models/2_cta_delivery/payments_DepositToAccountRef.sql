select
    _airbyte_payments_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_DepositToAccountRef_hashid
from {{ source('cta','payments_DepositToAccountRef_base') }}

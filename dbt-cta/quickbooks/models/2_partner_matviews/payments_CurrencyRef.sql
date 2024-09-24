select
    _airbyte_payments_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','payments_CurrencyRef_base') }}

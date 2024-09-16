select
    _airbyte_accounts_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','accounts_CurrencyRef_base') }}

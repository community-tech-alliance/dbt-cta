select
    _airbyte_transfers_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','transfers_CurrencyRef_base') }}
select
    _airbyte_vendors_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','vendors_CurrencyRef_base') }}
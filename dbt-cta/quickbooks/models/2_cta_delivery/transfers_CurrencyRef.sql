select
    _airbyte_transfers_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','transfers_CurrencyRef_base') }}

select
    _airbyte_deposits_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','deposits_CurrencyRef_base') }}

select
    _airbyte_purchases_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','purchases_CurrencyRef_base') }}

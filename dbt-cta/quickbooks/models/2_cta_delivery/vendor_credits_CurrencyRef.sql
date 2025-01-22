select
    _airbyte_vendor_credits_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','vendor_credits_CurrencyRef_base') }}

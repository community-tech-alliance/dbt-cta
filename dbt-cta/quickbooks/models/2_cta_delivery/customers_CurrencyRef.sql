select
    _airbyte_customers_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','customers_CurrencyRef_base') }}

select
    _airbyte_invoices_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','invoices_CurrencyRef_base') }}

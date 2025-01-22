select
    _airbyte_invoices_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_SalesTermRef_hashid
from {{ source('cta','invoices_SalesTermRef_base') }}

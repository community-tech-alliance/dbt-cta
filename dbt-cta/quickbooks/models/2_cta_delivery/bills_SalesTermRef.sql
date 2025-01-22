select
    _airbyte_bills_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_SalesTermRef_hashid
from {{ source('cta','bills_SalesTermRef_base') }}

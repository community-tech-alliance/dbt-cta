select
    _airbyte_bills_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_APAccountRef_hashid
from {{ source('cta','bills_APAccountRef_base') }}

select
    _airbyte_vendors_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_TermRef_hashid
from {{ source('cta','vendors_TermRef_base') }}

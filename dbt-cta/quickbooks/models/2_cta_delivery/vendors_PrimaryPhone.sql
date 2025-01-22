select
    _airbyte_vendors_hashid,
    FreeFormNumber,
    _airbyte_extracted_at,
    _airbyte_PrimaryPhone_hashid
from {{ source('cta','vendors_PrimaryPhone_base') }}

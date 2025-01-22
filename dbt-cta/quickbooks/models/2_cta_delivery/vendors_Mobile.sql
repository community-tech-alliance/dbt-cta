select
    _airbyte_vendors_hashid,
    FreeFormNumber,
    _airbyte_extracted_at,
    _airbyte_Mobile_hashid
from {{ source('cta','vendors_Mobile_base') }}

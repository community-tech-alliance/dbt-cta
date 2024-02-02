select
    id,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    source_code,
    _airbyte_source_codes_hashid
from {{ source('cta','source_codes_base') }}

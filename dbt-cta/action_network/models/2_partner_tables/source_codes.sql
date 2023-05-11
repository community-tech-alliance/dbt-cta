select
    _airbyte_emitted_at,
    id,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    source_code
from {{ source('cta','source_codes_base') }}
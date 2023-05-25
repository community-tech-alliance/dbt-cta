select
    id,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    source_code,
    _airbyte_source_codes_hashid
from {{ ref('source_codes_base') }}
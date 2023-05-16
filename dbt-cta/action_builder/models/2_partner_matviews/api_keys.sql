select
    _airbyte_emitted_at,
    id,
    target,
    api_key,
    created_at,
    revoked_at,
    updated_at,
    created_by_id,
    revoked_by_id,
    _airbyte_api_keys_hashid
from {{ source('cta','api_keys_base') }}
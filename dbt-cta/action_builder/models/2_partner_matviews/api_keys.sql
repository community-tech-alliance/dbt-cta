select
    id,
    target,
    api_key,
    created_at,
    revoked_at,
    updated_at,
    created_by_id,
    revoked_by_id
from {{ source('cta','api_keys_base') }}

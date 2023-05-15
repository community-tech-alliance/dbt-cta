select
    _airbyte_emitted_at,
    id,
    name,
    uuid,
    params,
    user_id,
    group_id,
    created_at,
    creator_id,
    updated_at
from {{ source('cta','queries_base') }}
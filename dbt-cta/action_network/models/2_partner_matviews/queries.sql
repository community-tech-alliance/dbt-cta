select
    id,
    name,
    uuid,
    params,
    user_id,
    group_id,
    created_at,
    creator_id,
    updated_at,
    _airbyte_queries_hashid
from {{ source('cta','queries_base') }}

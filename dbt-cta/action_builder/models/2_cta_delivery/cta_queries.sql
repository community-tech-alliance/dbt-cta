select
    _airbyte_emitted_at,
    id,
    body,
    name,
    public,
    user_id,
    temporary,
    created_at,
    query_type,
    updated_at,
    campaign_id,
    _airbyte_queries_hashid
from {{ source('cta','queries_base') }}

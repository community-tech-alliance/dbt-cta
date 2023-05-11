select
    _airbyte_emitted_at,
    id,
    name,
    status,
    group_id,
    created_at,
    target_url,
    updated_at
from {{ source('cta','webhooks_base') }}
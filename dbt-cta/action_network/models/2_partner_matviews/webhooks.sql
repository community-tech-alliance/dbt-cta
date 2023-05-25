select
    id,
    name,
    status,
    group_id,
    created_at,
    target_url,
    updated_at,
    _airbyte_webhooks_hashid
from {{ ref('webhooks_base') }}
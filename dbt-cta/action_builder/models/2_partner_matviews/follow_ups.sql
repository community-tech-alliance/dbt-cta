select
    _airbyte_emitted_at,
    id,
    entity_id,
    created_at,
    updated_at,
    campaign_id,
    completed_at,
    created_by_id,
    completed_by_id,
    assigned_user_id,
    _airbyte_follow_ups_hashid
from {{ source('cta','follow_ups_base') }}

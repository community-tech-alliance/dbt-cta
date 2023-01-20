select
    id,
    entity_id,
    created_at,
    updated_at,
    campaign_id,
    completed_at,
    created_by_id,
    completed_by_id,
    assigned_user_id
from {{ source('cta','follow_ups_base') }}

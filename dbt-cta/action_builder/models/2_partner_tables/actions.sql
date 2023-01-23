select
    id,
    name,
    text,
    active,
    due_date,
    completed,
    created_at,
    updated_at,
    campaign_id,
    created_by_id,
    entity_type_id,
    quick_check_in,
    canvassing_type,
    canvassing_enabled,
    targets_query_json
from {{ source('cta','actions_base') }}

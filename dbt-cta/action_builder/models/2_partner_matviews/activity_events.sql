select
    id,
    name,
    item_id,
    payload,
    user_id,
    datetime,
    item_type,
    target_id,
    created_at,
    event_type,
    updated_at,
    campaign_id,
    target_type
from {{ source('cta','activity_events_base') }}

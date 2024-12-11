select
    id,
    status,
    event_id,
    created_at,
    updated_at,
    event_campaign_id,
    _airbyte_event_campaign_invites_hashid
from {{ source('cta','event_campaign_invites_base') }}

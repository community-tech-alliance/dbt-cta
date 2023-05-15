select
    _airbyte_emitted_at,
    id,
    status,
    event_id,
    created_at,
    updated_at,
    event_campaign_id
from {{ source('cta','event_campaign_invites_base') }}
select
    _airbyte_emitted_at,
    id,
    text,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    created_by_id,
    _airbyte_campaign_context_notes_hashid
from {{ source('cta','campaign_context_notes_base') }}
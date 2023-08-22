select
    _airbyte_emitted_at,
    id,
    user_id,
    created_at,
    updated_at,
    campaign_id,
    _airbyte_campaign_participations_hashid
from {{ source('cta','campaign_participations_base') }}

select
    id,
    source_id,
    created_at,
    updated_at,
    campaign_id,
    source_type,
    _airbyte_actions_hashid
from {{ ref('actions_base') }}
select
    _airbyte_emitted_at,
    id,
    source_id,
    created_at,
    updated_at,
    campaign_id,
    source_type
from {{ source('cta','actions_base') }}
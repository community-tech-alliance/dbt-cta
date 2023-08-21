select
    _airbyte_emitted_at,
    id,
    cursor,
    created_at,
    updated_at,
    campaign_id,
    _airbyte_entity_sync_cursors_hashid
from {{ source('cta','entity_sync_cursors_base') }}

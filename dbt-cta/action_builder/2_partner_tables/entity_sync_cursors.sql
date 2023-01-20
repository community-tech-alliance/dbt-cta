select
    id,
    cursor,
    created_at,
    updated_at,
    campaign_id
from {{ source('cta','entity_sync_cursors_base') }}

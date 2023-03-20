select
    id,
    run_at,
    entity_id,
    operation,
    created_at,
    updated_at,
    campaign_id,
    external_entity_id
from {{ source('cta','entity_sync_stored_operations_base') }}

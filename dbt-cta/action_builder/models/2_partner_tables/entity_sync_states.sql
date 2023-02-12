select
    id,
    last_run,
    entity_id,
    created_at,
    updated_at,
    comparable_id,
    comparable_type,
    external_entity_id,
    external_compared_id,
    external_compared_type,
    service_integration_type,
    organization_integration_id
from {{ source('cta','entity_sync_states_base') }}
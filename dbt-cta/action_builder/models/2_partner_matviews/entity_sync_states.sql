select
    _airbyte_emitted_at,
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
    organization_integration_id,
    _airbyte_entity_sync_states_hashid
from {{ source('cta','entity_sync_states_base') }}
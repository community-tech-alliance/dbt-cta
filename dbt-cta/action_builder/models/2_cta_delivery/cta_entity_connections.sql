select
    _airbyte_emitted_at,
    id,
    status,
    imported,
    created_at,
    deleted_at,
    updated_at,
    campaign_id,
    interact_id,
    to_entity_id,
    created_by_id,
    deleted_by_id,
    updated_by_id,
    from_entity_id,
    entity_connection_type_id,
    _airbyte_entity_connections_hashid
from {{ source('cta','entity_connections_base') }}
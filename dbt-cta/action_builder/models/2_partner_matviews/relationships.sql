select
    id,
    deleted,
    created_at,
    deleted_at,
    updated_at,
    to_entity_id,
    created_by_id,
    deleted_by_id,
    updated_by_id,
    from_entity_id,
    _airbyte_relationships_hashid
from {{ source('cta','relationships_base') }}
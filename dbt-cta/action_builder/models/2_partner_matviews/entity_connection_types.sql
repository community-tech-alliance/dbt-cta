select
    id,
    created_at,
    updated_at,
    interact_id,
    created_by_id,
    updated_by_id,
    display_position,
    entity_type_1_id,
    entity_type_2_id
from {{ source('cta','entity_connection_types_base') }}

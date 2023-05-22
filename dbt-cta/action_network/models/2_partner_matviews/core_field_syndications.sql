select
    id,
    group_id,
    hierarchy,
    created_at,
    updated_at,
    source_group_id,
    _airbyte_core_field_syndications_hashid
from {{ source('cta','core_field_syndications_base') }}
select
    _airbyte_emitted_at,
    id,
    group_id,
    hierarchy,
    created_at,
    updated_at,
    source_group_id
from {{ source('cta','core_field_syndications_base') }}
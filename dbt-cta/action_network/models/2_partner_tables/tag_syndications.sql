select
    _airbyte_emitted_at,
    id,
    tag_id,
    group_id,
    tag_name,
    hierarchy,
    created_at,
    updated_at,
    source_group_id
from {{ source('cta','tag_syndications_base') }}
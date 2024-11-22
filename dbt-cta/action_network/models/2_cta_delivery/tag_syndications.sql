select
    id,
    tag_id,
    group_id,
    tag_name,
    hierarchy,
    created_at,
    updated_at,
    source_group_id,
    _airbyte_tag_syndications_hashid
from {{ source('cta','tag_syndications_base') }}

select
    _airbyte_emitted_at,
    id,
    tag_id,
    created_at,
    updated_at,
    turf_assignment_id,
    _airbyte_turf_tags_hashid
from {{ source('cta','turf_tags_base') }}
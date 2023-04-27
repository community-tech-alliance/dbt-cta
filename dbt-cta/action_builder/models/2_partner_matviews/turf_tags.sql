select
    id,
    tag_id,
    created_at,
    updated_at,
    turf_assignment_id
from {{ source('cta','turf_tags_base') }}

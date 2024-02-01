select
    _airbyte_emitted_at,
    id,
    user_id,
    created_at,
    updated_at,
    campaign_id,
    restriction_enabled,
    _airbyte_turf_assignments_hashid
from {{ source('cta','turf_assignments_base') }}

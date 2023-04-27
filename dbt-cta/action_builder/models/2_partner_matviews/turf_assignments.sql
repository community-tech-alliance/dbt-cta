select
    id,
    user_id,
    created_at,
    updated_at,
    campaign_id,
    restriction_enabled
from {{ source('cta','turf_assignments_base') }}

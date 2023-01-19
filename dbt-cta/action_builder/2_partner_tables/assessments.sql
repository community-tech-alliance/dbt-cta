select
    id,
    level,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    created_by_id,
    updated_by_id
from {{ source('cta','assessments_base') }}

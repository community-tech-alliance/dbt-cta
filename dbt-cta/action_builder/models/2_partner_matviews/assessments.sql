select
    _airbyte_emitted_at,
    id,
    level,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    created_by_id,
    updated_by_id,
    _airbyte_assessments_hashid
from {{ source('cta','assessments_base') }}

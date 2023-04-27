select
    id,
    user_id,
    created_at,
    updated_at,
    campaign_id
from {{ source('cta','campaign_participations_base') }}

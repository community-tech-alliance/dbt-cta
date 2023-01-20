select
    id,
    created_at,
    updated_at,
    campaign_id,
    external_service_id
from {{ source('cta','integrations_base') }}

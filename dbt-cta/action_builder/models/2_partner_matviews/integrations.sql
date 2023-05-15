select
    _airbyte_emitted_at,
    id,
    created_at,
    updated_at,
    campaign_id,
    external_service_id,
    _airbyte_integrations_hashid
from {{ source('cta','integrations_base') }}
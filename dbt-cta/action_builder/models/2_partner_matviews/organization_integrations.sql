select
    id,
    settings,
    created_at,
    updated_at,
    service_name,
    _airbyte_organization_integrations_hashid
from {{ source('cta','organization_integrations_base') }}
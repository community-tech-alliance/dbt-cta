select
    id,
    settings,
    created_at,
    updated_at,
    service_name
from {{ source('cta','organization_integrations_base') }}

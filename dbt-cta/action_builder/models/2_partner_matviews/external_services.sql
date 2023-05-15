select
    _airbyte_emitted_at,
    id,
    client_id,
    created_at,
    expires_in,
    updated_at,
    workflow_id,
    access_token,
    service_name,
    client_secret,
    token_updated_at,
    _airbyte_external_services_hashid
from {{ source('cta','external_services_base') }}
select
    carrier,
    last_lookup,
    lookup_name,
    status_code,
    subscribe_status,
    service,
    organization_id,
    created_at,
    id,
    contact_number,
    user_number,
    last_error_code,
    _airbyte_emitted_at,
    _airbyte_organization_contact_hashid
from {{ source('cta','organization_contact_base') }}
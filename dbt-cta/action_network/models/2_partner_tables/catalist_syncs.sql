select
    _airbyte_emitted_at,
    id,
    token,
    active,
    client_id,
    source_id,
    created_at,
    dwid_field,
    updated_at,
    catalist_id,
    source_type,
    client_secret,
    token_expires_in,
    token_updated_at
from {{ source('cta','catalist_syncs_base') }}
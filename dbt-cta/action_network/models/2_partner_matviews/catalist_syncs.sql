select
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
    token_updated_at,
    _airbyte_catalist_syncs_hashid
from {{ source('cta','catalist_syncs_base') }}

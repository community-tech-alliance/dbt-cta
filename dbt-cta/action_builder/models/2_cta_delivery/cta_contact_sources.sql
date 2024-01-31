select
    _airbyte_emitted_at,
    id,
    name,
    created_at,
    sort_order,
    updated_at,
    _airbyte_contact_sources_hashid
from {{ source('cta','contact_sources_base') }}

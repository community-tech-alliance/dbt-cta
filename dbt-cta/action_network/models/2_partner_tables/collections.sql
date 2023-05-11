select
    _airbyte_emitted_at,
    id,
    title,
    group_id,
    created_at,
    network_id,
    updated_at
from {{ source('cta','collections_base') }}
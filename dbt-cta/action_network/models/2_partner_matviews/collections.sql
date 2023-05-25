select
    id,
    title,
    group_id,
    created_at,
    network_id,
    updated_at,
    _airbyte_collections_hashid
from {{ ref('collections_base') }}
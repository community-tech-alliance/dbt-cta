select
    id,
    group_id,
    created_at,
    updated_at,
    collection_id,
    _airbyte_collections_groups_hashid
from {{ ref('collections_groups_base') }}
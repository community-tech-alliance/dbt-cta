select
    id,
    group_id,
    created_at,
    updated_at,
    collection_id,
    _airbyte_collections_groups_hashid
from {{ source('cta','collections_groups_base') }}
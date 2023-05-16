select
    _airbyte_emitted_at,
    id,
    group_id,
    created_at,
    updated_at,
    collection_id
from {{ source('cta','collections_groups_base') }}
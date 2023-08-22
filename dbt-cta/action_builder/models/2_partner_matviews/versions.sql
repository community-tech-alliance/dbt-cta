select
    _airbyte_emitted_at,
    id,
    event,
    object,
    item_id,
    item_type,
    whodunnit,
    created_at,
    object_changes,
    _airbyte_versions_hashid
from {{ source('cta','versions_base') }}

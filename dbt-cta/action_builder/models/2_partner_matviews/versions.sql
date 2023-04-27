select
    id,
    event,
    object,
    item_id,
    item_type,
    whodunnit,
    created_at,
    object_changes
from {{ source('cta','versions_base') }}

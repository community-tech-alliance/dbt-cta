select
    _airbyte_emitted_at,
    id,
    name,
    size,
    artifact,
    mime_type,
    created_at,
    updated_at,
    attachable_id,
    created_by_id,
    attachable_type,
    _airbyte_attachments_hashid
from {{ source('cta','attachments_base') }}

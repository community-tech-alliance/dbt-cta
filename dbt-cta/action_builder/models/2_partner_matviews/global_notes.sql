select
    id,
    text,
    owner_id,
    note_type,
    pinned_at,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    pinned_by_id,
    created_by_id,
    updated_by_id,
    _airbyte_global_notes_hashid
from {{ source('cta','global_notes_base') }}
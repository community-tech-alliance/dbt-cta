select
    id,
    notes,
    tag_id,
    available,
    created_at,
    created_by,
    deleted_at,
    deleted_by,
    updated_at,
    campaign_id,
    interact_id,
    taggable_id,
    signature_id,
    taggable_type,
    updated_by_id
from {{ source('cta','taggable_logbook_base') }}

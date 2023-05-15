select
    _airbyte_emitted_at,
    id,
    phone,
    owner_id,
    source_id,
    created_at,
    owner_type,
    updated_at,
    source_type,
    kept_core_field_id,
    removed_core_field_id
from {{ source('cta','phone_dedupe_logs_base') }}
select
    id,
    phone,
    owner_id,
    source_id,
    created_at,
    owner_type,
    updated_at,
    source_type,
    kept_core_field_id,
    removed_core_field_id,
    _airbyte_phone_dedupe_logs_hashid
from {{ ref('phone_dedupe_logs_base') }}
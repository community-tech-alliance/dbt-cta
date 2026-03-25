select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    details,
    user_id,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type,
    action_taken
from {{ source('cta','ladder_logs_base') }}

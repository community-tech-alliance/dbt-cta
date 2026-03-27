select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    exit,
    user_id,
    group_id,
    ladder_id,
    step_uuid,
    created_at,
    updated_at
from {{ source('cta','ladder_logs_base') }}

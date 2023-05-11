select
    _airbyte_emitted_at,
    id,
    rung_id,
    step_id,
    user_id,
    ladder_id,
    wait_time,
    created_at,
    extra_data,
    updated_at
from {{ source('cta','user_ladder_statuses_base') }}
select
    _airbyte_emitted_at,
    id,
    uuid,
    rules,
    ladder_id,
    step_type,
    created_at,
    updated_at,
    next_step_id,
    alternate_next_step_id
from {{ source('cta','steps_base') }}
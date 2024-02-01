select
    _airbyte_emitted_at,
    id,
    end_time,
    shift_id,
    created_at,
    start_time,
    updated_at,
    day_of_week,
    _airbyte_shift_times_hashid
from {{ source('cta','shift_times_base') }}

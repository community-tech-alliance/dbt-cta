select
    id,
    end_time,
    shift_id,
    created_at,
    start_time,
    updated_at,
    day_of_week
from {{ source('cta','shift_times_base') }}

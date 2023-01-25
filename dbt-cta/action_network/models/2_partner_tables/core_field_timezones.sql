select
    id,
    timezone,
    created_at,
    updated_at,
    core_field_id
from {{ source('cta','core_field_timezones_base') }}
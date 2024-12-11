select
    id,
    timezone,
    created_at,
    updated_at,
    core_field_id,
    _airbyte_core_field_timezones_hashid
from {{ source('cta','core_field_timezones_base') }}

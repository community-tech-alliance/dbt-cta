select
    id,
    timezone,
    created_at,
    updated_at,
    core_field_id,
    _airbyte_core_field_timezones_hashid
from {{ ref('core_field_timezones_base') }}
select
    _airbyte_emitted_at,
    id,
    county_id,
    core_field_id
from {{ source('cta','core_fields_counties_base') }}
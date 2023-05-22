select
    id,
    county_id,
    core_field_id,
    _airbyte_core_fields_counties_hashid
from {{ source('cta','core_fields_counties_base') }}
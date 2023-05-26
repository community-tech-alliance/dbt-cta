select
    id,
    created_at,
    updated_at,
    county_state,
    _airbyte_counties_hashid
from {{ source('cta','counties_base') }}
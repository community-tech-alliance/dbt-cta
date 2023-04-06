select
    id,
    created_at,
    updated_at,
    county_state
from {{ source('cta','counties_base') }}
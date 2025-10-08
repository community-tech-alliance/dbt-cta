select *
from {{ source('cta', 'events_customemailgroup_base') }}

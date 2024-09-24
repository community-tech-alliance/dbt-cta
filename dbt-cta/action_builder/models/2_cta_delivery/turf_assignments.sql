select *
from {{ source('cta', 'turf_assignments_base') }}

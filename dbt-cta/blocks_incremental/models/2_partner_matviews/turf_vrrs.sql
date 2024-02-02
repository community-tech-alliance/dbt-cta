select *
from {{ source('cta', 'turf_vrrs') }}

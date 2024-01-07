select *
from {{ source('cta', 'turf_pvqs') }}

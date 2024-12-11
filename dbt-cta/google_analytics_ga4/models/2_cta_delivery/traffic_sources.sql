select *
from {{ source('cta', 'traffic_sources_base') }}

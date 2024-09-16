select *
from {{ source('cta', 'voter_sources_base') }}

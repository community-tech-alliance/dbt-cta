select *
from {{ source('cta', 'petitions_canvasser_pages_base') }}

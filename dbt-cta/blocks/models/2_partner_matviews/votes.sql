select *
from {{ source('cta', 'votes_base') }}

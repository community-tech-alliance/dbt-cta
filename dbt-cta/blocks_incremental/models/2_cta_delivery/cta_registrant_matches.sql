select *
from {{ source('cta', 'registrant_matches_base') }}

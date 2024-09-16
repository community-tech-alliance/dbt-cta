select *
from {{ source('cta', 'state_party_codes_base') }}

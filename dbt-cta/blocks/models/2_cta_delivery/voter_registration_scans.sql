select *
from {{ source('cta', 'voter_registration_scans_base') }}

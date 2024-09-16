select *
from {{ source('cta', 'contact_attempts_base') }}

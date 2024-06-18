select *
from {{ source('cta', 'ivr_contact_base') }}

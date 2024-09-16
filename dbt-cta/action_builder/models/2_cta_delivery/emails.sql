select *
from {{ source('cta', 'emails_base') }}

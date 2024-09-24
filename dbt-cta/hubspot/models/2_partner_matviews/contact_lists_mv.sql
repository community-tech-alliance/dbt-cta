select *
from {{ source('cta', 'contact_lists_base') }}

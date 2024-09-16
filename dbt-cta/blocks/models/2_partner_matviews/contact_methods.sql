select *
from {{ source('cta', 'contact_methods_base') }}

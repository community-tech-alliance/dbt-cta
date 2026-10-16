select *
from {{ source('cta', 'custom_fields_base') }}

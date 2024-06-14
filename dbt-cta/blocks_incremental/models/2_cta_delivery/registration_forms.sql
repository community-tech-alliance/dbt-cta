select *
from {{ source('cta', 'registration_forms_base') }}

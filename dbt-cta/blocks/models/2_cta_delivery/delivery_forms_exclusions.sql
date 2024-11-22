select *
from {{ source('cta', 'delivery_forms_exclusions_base') }}

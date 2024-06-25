select *
from {{ source('cta', 'catalist_uploads_registration_forms_base') }}

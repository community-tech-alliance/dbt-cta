select *
from {{ source('cta', 'email_templates_base') }}

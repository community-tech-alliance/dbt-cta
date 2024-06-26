select *
from {{ source('cta', 'email_templates_events_base') }}

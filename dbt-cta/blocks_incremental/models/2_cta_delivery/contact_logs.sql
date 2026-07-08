select *
from {{ source('cta', 'contact_logs_base') }}

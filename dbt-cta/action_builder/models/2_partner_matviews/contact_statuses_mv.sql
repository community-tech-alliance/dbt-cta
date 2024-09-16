select *
from {{ source('cta', 'contact_statuses_base') }}

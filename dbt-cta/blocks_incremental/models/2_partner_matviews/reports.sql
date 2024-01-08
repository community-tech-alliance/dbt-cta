select *
from {{ source('cta', 'reports_base') }}

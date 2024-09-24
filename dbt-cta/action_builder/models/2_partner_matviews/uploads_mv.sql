select *
from {{ source('cta', 'uploads_base') }}

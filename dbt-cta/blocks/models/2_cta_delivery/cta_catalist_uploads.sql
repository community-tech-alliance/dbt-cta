select *
from {{ source('cta', 'catalist_uploads_base') }}

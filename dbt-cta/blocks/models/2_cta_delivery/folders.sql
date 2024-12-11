select *
from {{ source('cta', 'folders_base') }}

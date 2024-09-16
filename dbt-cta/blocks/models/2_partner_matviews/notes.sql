select *
from {{ source('cta', 'notes_base') }}

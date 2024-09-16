select *
from {{ source('cta', 'global_notes_base') }}

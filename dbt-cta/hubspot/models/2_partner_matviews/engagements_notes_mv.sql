select *
from {{ source('cta', 'engagements_notes_base') }}

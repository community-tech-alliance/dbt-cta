select *
from {{ source('cta', 'campaign_context_notes_base') }}

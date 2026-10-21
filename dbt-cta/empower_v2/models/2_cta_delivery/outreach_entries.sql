select *
from {{ source('cta', 'outreach_entries_base') }}

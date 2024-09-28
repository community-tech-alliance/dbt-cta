select *
from {{ source('cta', 'owners_archived_base') }}

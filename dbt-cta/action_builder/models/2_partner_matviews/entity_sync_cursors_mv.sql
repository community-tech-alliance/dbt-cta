select *
from {{ source('cta', 'entity_sync_cursors_base') }}

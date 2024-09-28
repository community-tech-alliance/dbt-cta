select *
from {{ source('cta', 'entity_sync_stored_operations_base') }}

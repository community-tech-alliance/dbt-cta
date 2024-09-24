select *
from {{ source('cta', 'entity_connection_types_base') }}

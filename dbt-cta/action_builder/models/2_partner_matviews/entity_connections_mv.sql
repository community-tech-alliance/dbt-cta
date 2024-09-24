select *
from {{ source('cta', 'entity_connections_base') }}

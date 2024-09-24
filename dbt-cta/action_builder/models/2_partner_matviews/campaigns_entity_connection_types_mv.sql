select *
from {{ source('cta', 'campaigns_entity_connection_types_base') }}

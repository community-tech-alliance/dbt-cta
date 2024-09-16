select *
from {{ source('cta', 'entity_types_base') }}

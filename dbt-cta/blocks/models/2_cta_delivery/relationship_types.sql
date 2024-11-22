select *
from {{ source('cta', 'relationship_types_base') }}

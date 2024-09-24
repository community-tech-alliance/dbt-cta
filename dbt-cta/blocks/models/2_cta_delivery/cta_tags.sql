select *
from {{ source('cta', 'tags_base') }}

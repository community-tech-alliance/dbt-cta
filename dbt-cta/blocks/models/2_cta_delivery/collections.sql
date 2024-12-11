select *
from {{ source('cta', 'collections_base') }}

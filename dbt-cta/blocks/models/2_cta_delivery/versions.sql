select *
from {{ source('cta', 'versions_base') }}

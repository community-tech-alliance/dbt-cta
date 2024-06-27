select *
from {{ source('cta', 'clicks_base') }}

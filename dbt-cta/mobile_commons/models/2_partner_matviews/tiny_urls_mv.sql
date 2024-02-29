select *
from {{ source('cta', 'tiny_urls_base') }}

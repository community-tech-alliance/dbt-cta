select *
from {{ source('cta', 'quick_links_base') }}

select *
from {{ source('cta', 'keywords_base') }}

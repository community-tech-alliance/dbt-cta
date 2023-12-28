select *
from {{ source('cta', 'parties_base') }}

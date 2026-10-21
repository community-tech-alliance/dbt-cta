select *
from {{ source('cta', 'facts_base') }}

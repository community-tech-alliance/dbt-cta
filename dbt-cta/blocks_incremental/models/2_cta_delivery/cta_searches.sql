select *
from {{ source('cta', 'searches_base') }}

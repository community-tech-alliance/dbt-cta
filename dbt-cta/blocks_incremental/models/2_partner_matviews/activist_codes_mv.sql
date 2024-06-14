select *
from {{ source('cta', 'activist_codes_base') }}

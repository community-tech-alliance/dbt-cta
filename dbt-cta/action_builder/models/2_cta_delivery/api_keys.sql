select *
from {{ source('cta', 'api_keys_base') }}

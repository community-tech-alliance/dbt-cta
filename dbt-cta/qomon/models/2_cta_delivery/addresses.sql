select *
from {{ source('cta', 'addresses_base') }}

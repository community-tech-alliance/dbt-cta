select *
from {{ source('cta', 'phone_numbers_base') }}

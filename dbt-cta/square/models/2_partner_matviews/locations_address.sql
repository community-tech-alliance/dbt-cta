select *
from {{ source('cta','locations_address_base') }}

select *
from {{ source('cta','customers_address_base') }}

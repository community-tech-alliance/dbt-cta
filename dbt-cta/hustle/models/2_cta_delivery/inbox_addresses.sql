select *
from {{ source('cta','inbox_addresses_base') }}

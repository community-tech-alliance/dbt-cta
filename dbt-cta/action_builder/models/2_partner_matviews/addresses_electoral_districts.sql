select
    address_id,
    electoral_district_ocd_id
from {{ source('cta','addresses_electoral_districts_base') }}

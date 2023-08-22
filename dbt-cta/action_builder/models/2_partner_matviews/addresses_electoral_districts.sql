select
    _airbyte_emitted_at,
    address_id,
    electoral_district_ocd_id,
    _airbyte_addresses_electoral_districts_hashid
from {{ source('cta','addresses_electoral_districts_base') }}

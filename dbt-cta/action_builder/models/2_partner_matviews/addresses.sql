select
    id,
    city,
    dw_id,
    state,
    source,
    status,
    country,
    accuracy,
    latitude,
    owner_id,
    timezone,
    longitude,
    complement,
    created_at,
    owner_type,
    updated_at,
    geocode_bad,
    interact_id,
    postal_code,
    accuracy_type,
    created_by_id,
    updated_by_id,
    geocode_source,
    street_address,
    _airbyte_addresses_hashid
from {{ source('cta','addresses_base') }}
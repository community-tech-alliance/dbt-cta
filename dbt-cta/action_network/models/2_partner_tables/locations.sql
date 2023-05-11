select
    _airbyte_emitted_at,
    id,
    city,
    state,
    status,
    address,
    country,
    event_id,
    latitude,
    zip_code,
    longitude,
    created_at,
    updated_at,
    location_name,
    event_campaign_id,
    event_campaign_upload_id
from {{ source('cta','locations_base') }}
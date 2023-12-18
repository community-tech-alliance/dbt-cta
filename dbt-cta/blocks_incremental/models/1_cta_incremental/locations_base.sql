{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('locations_ab3') }}
select
    street_address,
    primary_point_of_contact,
    notes,
    contact_phone,
    has_hosted_event,
    city,
    timezone,
    latitude,
    county,
    extras,
    created_at,
    forms_per_hour,
    has_it_support,
    contact_email,
    score,
    rooms_available,
    updated_at,
    turf_id,
    has_public_transportation,
    id,
    state,
    email,
    longitude,
    hours,
    contact_name,
    maximum_occupancy,
    largest_turnout,
    has_projector,
    parking_spots_available,
    venue_info,
    created_by_user_id,
    location_type,
    zipcode,
    precinct,
    geoid,
    name,
    phone_number,
    has_wifi,
    registration_forms_count,
    has_av,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_locations_hashid
from {{ ref('locations_ab3') }}
-- locations from {{ source('cta', '_airbyte_raw_locations') }}


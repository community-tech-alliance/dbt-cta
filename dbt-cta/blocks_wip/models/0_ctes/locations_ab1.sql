{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_locations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['street_address'], ['street_address']) }} as street_address,
    {{ json_extract_scalar('_airbyte_data', ['primary_point_of_contact'], ['primary_point_of_contact']) }} as primary_point_of_contact,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['contact_phone'], ['contact_phone']) }} as contact_phone,
    {{ json_extract_scalar('_airbyte_data', ['has_hosted_event'], ['has_hosted_event']) }} as has_hosted_event,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['forms_per_hour'], ['forms_per_hour']) }} as forms_per_hour,
    {{ json_extract_scalar('_airbyte_data', ['has_it_support'], ['has_it_support']) }} as has_it_support,
    {{ json_extract_scalar('_airbyte_data', ['contact_email'], ['contact_email']) }} as contact_email,
    {{ json_extract_scalar('_airbyte_data', ['score'], ['score']) }} as score,
    {{ json_extract_scalar('_airbyte_data', ['rooms_available'], ['rooms_available']) }} as rooms_available,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['has_public_transportation'], ['has_public_transportation']) }} as has_public_transportation,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    {{ json_extract_scalar('_airbyte_data', ['hours'], ['hours']) }} as hours,
    {{ json_extract_scalar('_airbyte_data', ['contact_name'], ['contact_name']) }} as contact_name,
    {{ json_extract_scalar('_airbyte_data', ['maximum_occupancy'], ['maximum_occupancy']) }} as maximum_occupancy,
    {{ json_extract_scalar('_airbyte_data', ['largest_turnout'], ['largest_turnout']) }} as largest_turnout,
    {{ json_extract_scalar('_airbyte_data', ['has_projector'], ['has_projector']) }} as has_projector,
    {{ json_extract_scalar('_airbyte_data', ['parking_spots_available'], ['parking_spots_available']) }} as parking_spots_available,
    {{ json_extract_scalar('_airbyte_data', ['venue_info'], ['venue_info']) }} as venue_info,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['location_type'], ['location_type']) }} as location_type,
    {{ json_extract_scalar('_airbyte_data', ['zipcode'], ['zipcode']) }} as zipcode,
    {{ json_extract_scalar('_airbyte_data', ['precinct'], ['precinct']) }} as precinct,
    {{ json_extract_scalar('_airbyte_data', ['geoid'], ['geoid']) }} as geoid,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['has_wifi'], ['has_wifi']) }} as has_wifi,
    {{ json_extract_scalar('_airbyte_data', ['registration_forms_count'], ['registration_forms_count']) }} as registration_forms_count,
    {{ json_extract_scalar('_airbyte_data', ['has_av'], ['has_av']) }} as has_av,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_locations') }} as table_alias
-- locations
where 1 = 1


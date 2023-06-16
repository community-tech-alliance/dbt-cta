{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('locations_ab1') }}
select
    cast(street_address as {{ dbt_utils.type_string() }}) as street_address,
    cast(primary_point_of_contact as {{ dbt_utils.type_string() }}) as primary_point_of_contact,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(contact_phone as {{ dbt_utils.type_string() }}) as contact_phone,
    {{ cast_to_boolean('has_hosted_event') }} as has_hosted_event,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(forms_per_hour as {{ dbt_utils.type_float() }}) as forms_per_hour,
    {{ cast_to_boolean('has_it_support') }} as has_it_support,
    cast(contact_email as {{ dbt_utils.type_string() }}) as contact_email,
    cast(score as {{ dbt_utils.type_float() }}) as score,
    cast(rooms_available as {{ dbt_utils.type_bigint() }}) as rooms_available,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    {{ cast_to_boolean('has_public_transportation') }} as has_public_transportation,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    cast(hours as {{ dbt_utils.type_string() }}) as hours,
    cast(contact_name as {{ dbt_utils.type_string() }}) as contact_name,
    cast(maximum_occupancy as {{ dbt_utils.type_bigint() }}) as maximum_occupancy,
    cast(largest_turnout as {{ dbt_utils.type_bigint() }}) as largest_turnout,
    {{ cast_to_boolean('has_projector') }} as has_projector,
    cast(parking_spots_available as {{ dbt_utils.type_bigint() }}) as parking_spots_available,
    cast(venue_info as {{ dbt_utils.type_string() }}) as venue_info,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(location_type as {{ dbt_utils.type_bigint() }}) as location_type,
    cast(zipcode as {{ dbt_utils.type_string() }}) as zipcode,
    cast(precinct as {{ dbt_utils.type_string() }}) as precinct,
    cast(geoid as {{ dbt_utils.type_string() }}) as geoid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    {{ cast_to_boolean('has_wifi') }} as has_wifi,
    cast(registration_forms_count as {{ dbt_utils.type_bigint() }}) as registration_forms_count,
    {{ cast_to_boolean('has_av') }} as has_av,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('locations_ab1') }}
-- locations
where 1 = 1


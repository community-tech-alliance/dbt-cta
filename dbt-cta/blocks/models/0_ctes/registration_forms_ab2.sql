{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('registration_forms_ab1') }}
select
    cast(distance_from_location as {{ dbt_utils.type_float() }}) as distance_from_location,
    cast(metadata as {{ dbt_utils.type_string() }}) as metadata,
    {{ cast_to_boolean('eligible_voting_age') }} as eligible_voting_age,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    {{ cast_to_boolean('social_security') }} as social_security,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(pledge_card_data as {{ dbt_utils.type_string() }}) as pledge_card_data,
    cast(score as {{ dbt_utils.type_float() }}) as score,
    cast(identification as {{ dbt_utils.type_string() }}) as identification,
    cast(voting_state as {{ dbt_utils.type_string() }}) as voting_state,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('state_id') }} as state_id,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    cast(ovr_status as {{ dbt_utils.type_string() }}) as ovr_status,
    {{ cast_to_boolean('hard_copy_collected') }} as hard_copy_collected,
    cast(mailing_street_address_two as {{ dbt_utils.type_string() }}) as mailing_street_address_two,
    {{ cast_to_boolean('completed') }} as completed,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(registration_date as {{ dbt_utils.type_string() }}) as registration_date,
    {{ cast_to_boolean('secondary_identification') }} as secondary_identification,
    cast(voting_city as {{ dbt_utils.type_string() }}) as voting_city,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(form_number as {{ dbt_utils.type_string() }}) as form_number,
    cast(party as {{ dbt_utils.type_string() }}) as party,
    {{ cast_to_boolean('contacted_voter') }} as contacted_voter,
    cast(mailing_street_address_one as {{ dbt_utils.type_string() }}) as mailing_street_address_one,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(ethnicity as {{ dbt_utils.type_string() }}) as ethnicity,
    {{ cast_to_boolean('signature') }} as signature,
    cast(date_of_birth as {{ dbt_utils.type_string() }}) as date_of_birth,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(delivery_id as {{ dbt_utils.type_bigint() }}) as delivery_id,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(voting_street_address_two as {{ dbt_utils.type_string() }}) as voting_street_address_two,
    cast(voting_zipcode as {{ dbt_utils.type_string() }}) as voting_zipcode,
    cast(mailing_zipcode as {{ dbt_utils.type_string() }}) as mailing_zipcode,
    cast(registration_type as {{ dbt_utils.type_string() }}) as registration_type,
    redacted_fields,
    cast(van_id as {{ dbt_utils.type_string() }}) as van_id,
    cast(name_prefix as {{ dbt_utils.type_string() }}) as name_prefix,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    {{ cast_to_boolean('online_registration') }} as online_registration,
    cast(por_data as {{ dbt_utils.type_string() }}) as por_data,
    cast(mailing_city as {{ dbt_utils.type_string() }}) as mailing_city,
    cast(mailing_state as {{ dbt_utils.type_string() }}) as mailing_state,
    cast(voting_street_address_one as {{ dbt_utils.type_string() }}) as voting_street_address_one,
    cast(name_suffix as {{ dbt_utils.type_string() }}) as name_suffix,
    cast(twilio_match_data as {{ dbt_utils.type_string() }}) as twilio_match_data,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    {{ cast_to_boolean('us_citizen') }} as us_citizen,
    cast(precinct as {{ dbt_utils.type_string() }}) as precinct,
    cast(email_address as {{ dbt_utils.type_string() }}) as email_address,
    cast(smarty_streets_match_data as {{ dbt_utils.type_string() }}) as smarty_streets_match_data,
    cast(scan_id as {{ dbt_utils.type_bigint() }}) as scan_id,
    {{ cast_to_boolean('attempted') }} as attempted,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('registration_forms_ab1') }}
-- registration_forms
where 1 = 1

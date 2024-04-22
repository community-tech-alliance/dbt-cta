{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('scans_qc_overview_ab1') }}
select
    cast(distance_from_location as {{ dbt_utils.type_float() }}) as distance_from_location,
    {{ cast_to_boolean('eligible_voting_age') }} as eligible_voting_age,
    cast(canvasser_id as {{ dbt_utils.type_bigint() }}) as canvasser_id,
    cast(visual_qc_completed_by_user_id as {{ dbt_utils.type_bigint() }}) as visual_qc_completed_by_user_id,
    cast(program_state as {{ dbt_utils.type_string() }}) as program_state,
    cast({{ empty_string_to_null('data_entry_time') }} as {{ type_timestamp_without_timezone() }}) as data_entry_time,
    {{ cast_to_boolean('bad_number') }} as bad_number,
    cast({{ empty_string_to_null('field_start') }} as {{ type_timestamp_without_timezone() }}) as field_start,
    cast(shift_type as {{ dbt_utils.type_bigint() }}) as shift_type,
    cast(collection_location_id as {{ dbt_utils.type_bigint() }}) as collection_location_id,
    cast(identification as {{ dbt_utils.type_string() }}) as identification,
    cast(voter_registration_scan_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_id,
    cast(voting_state as {{ dbt_utils.type_string() }}) as voting_state,
    cast(collection_location_zip as {{ dbt_utils.type_string() }}) as collection_location_zip,
    cast(collection_location_city as {{ dbt_utils.type_string() }}) as collection_location_city,
    cast(collective_name as {{ dbt_utils.type_string() }}) as collective_name,
    cast(visual_qc_county as {{ dbt_utils.type_string() }}) as visual_qc_county,
    {{ cast_to_boolean('address_validated') }} as address_validated,
    cast({{ empty_string_to_null('qc_deadline') }} as {{ type_timestamp_without_timezone() }}) as qc_deadline,
    cast(mailing_street_address_two as {{ dbt_utils.type_string() }}) as mailing_street_address_two,
    cast(organization_name as {{ dbt_utils.type_string() }}) as organization_name,
    cast(canvasser_last_name as {{ dbt_utils.type_string() }}) as canvasser_last_name,
    cast({{ empty_string_to_null('shift_start') }} as {{ type_timestamp_without_timezone() }}) as shift_start,
    cast({{ empty_string_to_null('upload_time') }} as {{ type_timestamp_without_timezone() }}) as upload_time,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(voting_city as {{ dbt_utils.type_string() }}) as voting_city,
    cast(collection_location_name as {{ dbt_utils.type_string() }}) as collection_location_name,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(party as {{ dbt_utils.type_string() }}) as party,
    cast(voting_address_latitude as {{ dbt_utils.type_float() }}) as voting_address_latitude,
    cast(qc_organization as {{ dbt_utils.type_string() }}) as qc_organization,
    cast(mailing_street_address_one as {{ dbt_utils.type_string() }}) as mailing_street_address_one,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(ethnicity as {{ dbt_utils.type_string() }}) as ethnicity,
    {{ cast_to_boolean('signature') }} as signature,
    cast(turf_parent_id as {{ dbt_utils.type_bigint() }}) as turf_parent_id,
    cast({{ empty_string_to_null('date_of_birth') }} as {{ type_date() }}) as date_of_birth,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast(voting_street_address_two as {{ dbt_utils.type_string() }}) as voting_street_address_two,
    cast(voting_address_longitude as {{ dbt_utils.type_float() }}) as voting_address_longitude,
    cast(phone_verification_completed_by_user_id as {{ dbt_utils.type_bigint() }}) as phone_verification_completed_by_user_id,
    cast(voting_zipcode as {{ dbt_utils.type_string() }}) as voting_zipcode,
    cast(mailing_zipcode as {{ dbt_utils.type_string() }}) as mailing_zipcode,
    cast(registration_type as {{ dbt_utils.type_string() }}) as registration_type,
    cast(registration_form_id as {{ dbt_utils.type_bigint() }}) as registration_form_id,
    cast(packet_filename as {{ dbt_utils.type_string() }}) as packet_filename,
    cast(name_prefix as {{ dbt_utils.type_string() }}) as name_prefix,
    cast(collection_location_longitude as {{ dbt_utils.type_float() }}) as collection_location_longitude,
    {{ cast_to_boolean('through_visual_qc') }} as through_visual_qc,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(van_committee_id as {{ dbt_utils.type_string() }}) as van_committee_id,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(collection_location_latitude as {{ dbt_utils.type_float() }}) as collection_location_latitude,
    cast({{ empty_string_to_null('shift_end') }} as {{ type_timestamp_without_timezone() }}) as shift_end,
    cast(collection_location_county as {{ dbt_utils.type_string() }}) as collection_location_county,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(data_entry_county as {{ dbt_utils.type_string() }}) as data_entry_county,
    cast({{ empty_string_to_null('voter_registration_scan_updated_at') }} as {{ type_timestamp_without_timezone() }}) as voter_registration_scan_updated_at,
    {{ cast_to_boolean('digital') }} as digital,
    cast(mailing_city as {{ dbt_utils.type_string() }}) as mailing_city,
    {{ cast_to_boolean('is_registration_form') }} as is_registration_form,
    cast(voting_street_address_one as {{ dbt_utils.type_string() }}) as voting_street_address_one,
    cast(name_suffix as {{ dbt_utils.type_string() }}) as name_suffix,
    cast({{ empty_string_to_null('data_entry_updated_at') }} as {{ type_timestamp_without_timezone() }}) as data_entry_updated_at,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(voter_registration_scan_batches_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_batches_id,
    {{ cast_to_boolean('phone_validated') }} as phone_validated,
    cast(email_address as {{ dbt_utils.type_string() }}) as email_address,
    {{ cast_to_boolean('phone_verified') }} as phone_verified,
    cast(collection_location_street_address as {{ dbt_utils.type_string() }}) as collection_location_street_address,
    cast({{ empty_string_to_null('field_end') }} as {{ type_timestamp_without_timezone() }}) as field_end,
    cast(canvasser_first_name as {{ dbt_utils.type_string() }}) as canvasser_first_name,
    {{ cast_to_boolean('complete') }} as complete,
    {{ cast_to_boolean('has_phone_number_visual_qc') }} as has_phone_number_visual_qc,
    cast(collection_location_state as {{ dbt_utils.type_string() }}) as collection_location_state,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('scans_qc_overview_ab1') }}
-- scans_qc_overview
where 1 = 1


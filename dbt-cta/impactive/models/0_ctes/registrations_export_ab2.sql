{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('registrations_export_ab1') }}
select
    cast(encode_id as {{ dbt_utils.type_string() }}) as encode_id,
    {{ cast_to_boolean('has_state_identification') }} as has_state_identification,
    cast(voterbase_id as {{ dbt_utils.type_string() }}) as voterbase_id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast({{ empty_string_to_null('date_of_birth') }} as {{ type_date() }}) as date_of_birth,
    cast(registration_status as {{ dbt_utils.type_string() }}) as registration_status,
    cast(contact_referral_full_name as {{ dbt_utils.type_string() }}) as contact_referral_full_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(team_id as {{ dbt_utils.type_bigint() }}) as team_id,
    cast(contact_id as {{ dbt_utils.type_bigint() }}) as contact_id,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast(unit_number as {{ dbt_utils.type_string() }}) as unit_number,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('sms_opt_in') }} as sms_opt_in,
    {{ cast_to_boolean('different_address') }} as different_address,
    cast(voter_registration_status as {{ dbt_utils.type_string() }}) as voter_registration_status,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(activity_title as {{ dbt_utils.type_string() }}) as activity_title,
    cast(referral_link as {{ dbt_utils.type_string() }}) as referral_link,
    {{ cast_to_boolean('email_opt_in') }} as email_opt_in,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast({{ empty_string_to_null('completed_voter_registration_at') }} as {{ type_date() }}) as completed_voter_registration_at,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(county_name as {{ dbt_utils.type_string() }}) as county_name,
    cast(contact_referral_id as {{ dbt_utils.type_bigint() }}) as contact_referral_id,
    cast(team_name as {{ dbt_utils.type_string() }}) as team_name,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(state_abbrev as {{ dbt_utils.type_string() }}) as state_abbrev,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('registrations_export_ab1') }}
-- registrations_export
where 1 = 1


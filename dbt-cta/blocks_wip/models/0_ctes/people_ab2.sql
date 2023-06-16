{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('people_ab1') }}
select
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    ethnicity,
    cast(email_source as {{ dbt_utils.type_string() }}) as email_source,
    cast(interest_level as {{ dbt_utils.type_string() }}) as interest_level,
    cast(prefix as {{ dbt_utils.type_string() }}) as prefix,
    cast({{ empty_string_to_null('birth_date') }} as {{ type_date() }}) as birth_date,
    cast(call_stoppage as {{ dbt_utils.type_string() }}) as call_stoppage,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(denominations as {{ dbt_utils.type_string() }}) as denominations,
    cast(external_id as {{ dbt_utils.type_string() }}) as external_id,
    cast(issues as {{ dbt_utils.type_string() }}) as issues,
    cast(skills as {{ dbt_utils.type_string() }}) as skills,
    cast(search_terms as {{ dbt_utils.type_string() }}) as search_terms,
    cast(mailing_address_id as {{ dbt_utils.type_bigint() }}) as mailing_address_id,
    cast(residential_address_id as {{ dbt_utils.type_bigint() }}) as residential_address_id,
    cast(suffix_name as {{ dbt_utils.type_string() }}) as suffix_name,
    cast(primary_phone_number as {{ dbt_utils.type_string() }}) as primary_phone_number,
    {{ cast_to_boolean('requested_public_record_exception') }} as requested_public_record_exception,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(voter_source_id as {{ dbt_utils.type_bigint() }}) as voter_source_id,
    {{ cast_to_boolean('receives_sms') }} as receives_sms,
    cast(leadership_score as {{ dbt_utils.type_float() }}) as leadership_score,
    cast(registered_state as {{ dbt_utils.type_string() }}) as registered_state,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(assigned_to_user_id as {{ dbt_utils.type_bigint() }}) as assigned_to_user_id,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(voter_status as {{ dbt_utils.type_string() }}) as voter_status,
    cast(languages as {{ dbt_utils.type_string() }}) as languages,
    cast(primary_email_address as {{ dbt_utils.type_string() }}) as primary_email_address,
    cast(primary_language as {{ dbt_utils.type_string() }}) as primary_language,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(external_ids as {{ dbt_utils.type_string() }}) as external_ids,
    cast({{ empty_string_to_null('registration_date') }} as {{ type_date() }}) as registration_date,
    cast(best_contact_method as {{ dbt_utils.type_string() }}) as best_contact_method,
    cast(party_id as {{ dbt_utils.type_bigint() }}) as party_id,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast(pronouns as {{ dbt_utils.type_string() }}) as pronouns,
    cast(work_organization_id as {{ dbt_utils.type_bigint() }}) as work_organization_id,
    cast(position as {{ dbt_utils.type_string() }}) as position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('people_ab1') }}
-- people
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


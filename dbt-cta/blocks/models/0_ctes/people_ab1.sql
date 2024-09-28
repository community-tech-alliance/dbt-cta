{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_people') }}
select
    {{ json_extract_scalar('_airbyte_data', ['gender'], ['gender']) }} as gender,
    {{ json_extract_string_array('_airbyte_data', ['ethnicity'], ['ethnicity']) }} as ethnicity,
    {{ json_extract_scalar('_airbyte_data', ['email_source'], ['email_source']) }} as email_source,
    {{ json_extract_scalar('_airbyte_data', ['interest_level'], ['interest_level']) }} as interest_level,
    {{ json_extract_scalar('_airbyte_data', ['prefix'], ['prefix']) }} as prefix,
    {{ json_extract_scalar('_airbyte_data', ['birth_date'], ['birth_date']) }} as birth_date,
    {{ json_extract_scalar('_airbyte_data', ['call_stoppage'], ['call_stoppage']) }} as call_stoppage,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['denominations'], ['denominations']) }} as denominations,
    {{ json_extract_scalar('_airbyte_data', ['external_id'], ['external_id']) }} as external_id,
    {{ json_extract_scalar('_airbyte_data', ['issues'], ['issues']) }} as issues,
    {{ json_extract_scalar('_airbyte_data', ['skills'], ['skills']) }} as skills,
    {{ json_extract_scalar('_airbyte_data', ['search_terms'], ['search_terms']) }} as search_terms,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_id'], ['mailing_address_id']) }} as mailing_address_id,
    {{ json_extract_scalar('_airbyte_data', ['residential_address_id'], ['residential_address_id']) }} as residential_address_id,
    {{ json_extract_scalar('_airbyte_data', ['suffix_name'], ['suffix_name']) }} as suffix_name,
    {{ json_extract_scalar('_airbyte_data', ['primary_phone_number'], ['primary_phone_number']) }} as primary_phone_number,
    {{ json_extract_scalar('_airbyte_data', ['requested_public_record_exception'], ['requested_public_record_exception']) }} as requested_public_record_exception,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['voter_source_id'], ['voter_source_id']) }} as voter_source_id,
    {{ json_extract_scalar('_airbyte_data', ['receives_sms'], ['receives_sms']) }} as receives_sms,
    {{ json_extract_scalar('_airbyte_data', ['leadership_score'], ['leadership_score']) }} as leadership_score,
    {{ json_extract_scalar('_airbyte_data', ['registered_state'], ['registered_state']) }} as registered_state,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['assigned_to_user_id'], ['assigned_to_user_id']) }} as assigned_to_user_id,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['voter_status'], ['voter_status']) }} as voter_status,
    {{ json_extract_scalar('_airbyte_data', ['languages'], ['languages']) }} as languages,
    {{ json_extract_scalar('_airbyte_data', ['primary_email_address'], ['primary_email_address']) }} as primary_email_address,
    {{ json_extract_scalar('_airbyte_data', ['primary_language'], ['primary_language']) }} as primary_language,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['external_ids'], ['external_ids']) }} as external_ids,
    {{ json_extract_scalar('_airbyte_data', ['registration_date'], ['registration_date']) }} as registration_date,
    {{ json_extract_scalar('_airbyte_data', ['best_contact_method'], ['best_contact_method']) }} as best_contact_method,
    {{ json_extract_scalar('_airbyte_data', ['party_id'], ['party_id']) }} as party_id,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['pronouns'], ['pronouns']) }} as pronouns,
    {{ json_extract_scalar('_airbyte_data', ['work_organization_id'], ['work_organization_id']) }} as work_organization_id,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_people') }}
-- people
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


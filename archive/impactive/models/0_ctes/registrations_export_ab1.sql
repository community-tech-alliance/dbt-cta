{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_registrations_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['encode_id'], ['encode_id']) }} as encode_id,
    {{ json_extract_scalar('_airbyte_data', ['has_state_identification'], ['has_state_identification']) }} as has_state_identification,
    {{ json_extract_scalar('_airbyte_data', ['voterbase_id'], ['voterbase_id']) }} as voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['date_of_birth'], ['date_of_birth']) }} as date_of_birth,
    {{ json_extract_scalar('_airbyte_data', ['registration_status'], ['registration_status']) }} as registration_status,
    {{ json_extract_scalar('_airbyte_data', ['contact_referral_full_name'], ['contact_referral_full_name']) }} as contact_referral_full_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    {{ json_extract_scalar('_airbyte_data', ['contact_id'], ['contact_id']) }} as contact_id,
    {{ json_extract_scalar('_airbyte_data', ['zip_code'], ['zip_code']) }} as zip_code,
    {{ json_extract_scalar('_airbyte_data', ['unit_number'], ['unit_number']) }} as unit_number,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['sms_opt_in'], ['sms_opt_in']) }} as sms_opt_in,
    {{ json_extract_scalar('_airbyte_data', ['different_address'], ['different_address']) }} as different_address,
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_status'], ['voter_registration_status']) }} as voter_registration_status,
    {{ json_extract_scalar('_airbyte_data', ['activity_id'], ['activity_id']) }} as activity_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_title'], ['activity_title']) }} as activity_title,
    {{ json_extract_scalar('_airbyte_data', ['referral_link'], ['referral_link']) }} as referral_link,
    {{ json_extract_scalar('_airbyte_data', ['email_opt_in'], ['email_opt_in']) }} as email_opt_in,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['completed_voter_registration_at'], ['completed_voter_registration_at']) }} as completed_voter_registration_at,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['county_name'], ['county_name']) }} as county_name,
    {{ json_extract_scalar('_airbyte_data', ['contact_referral_id'], ['contact_referral_id']) }} as contact_referral_id,
    {{ json_extract_scalar('_airbyte_data', ['team_name'], ['team_name']) }} as team_name,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['state_abbrev'], ['state_abbrev']) }} as state_abbrev,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_registrations_export') }} as table_alias
-- registrations_export
where 1 = 1


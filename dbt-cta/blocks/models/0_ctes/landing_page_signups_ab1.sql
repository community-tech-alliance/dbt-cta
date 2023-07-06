{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_landing_page_signups') }}
select
    {{ json_extract_scalar('_airbyte_data', ['mailing_county'], ['mailing_county']) }} as mailing_county,
    {{ json_extract_scalar('_airbyte_data', ['state_api_submission_result'], ['state_api_submission_result']) }} as state_api_submission_result,
    {{ json_extract_scalar('_airbyte_data', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['voting_state'], ['voting_state']) }} as voting_state,
    {{ json_extract_scalar('_airbyte_data', ['finish_with_state'], ['finish_with_state']) }} as finish_with_state,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['tracking_source'], ['tracking_source']) }} as tracking_source,
    {{ json_extract_scalar('_airbyte_data', ['citizen'], ['citizen']) }} as citizen,
    {{ json_extract_scalar('_airbyte_data', ['phone_type'], ['phone_type']) }} as phone_type,
    {{ json_extract_scalar('_airbyte_data', ['mailing_street_address_two'], ['mailing_street_address_two']) }} as mailing_street_address_two,
    {{ json_extract_scalar('_airbyte_data', ['built_via_api'], ['built_via_api']) }} as built_via_api,
    {{ json_extract_scalar('_airbyte_data', ['organization_name'], ['organization_name']) }} as organization_name,
    {{ json_extract_scalar('_airbyte_data', ['vr_app_status_datetime'], ['vr_app_status_datetime']) }} as vr_app_status_datetime,
    {{ json_extract_scalar('_airbyte_data', ['opt_in_partner_sms'], ['opt_in_partner_sms']) }} as opt_in_partner_sms,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['started_registration_at'], ['started_registration_at']) }} as started_registration_at,
    {{ json_extract_scalar('_airbyte_data', ['voting_city'], ['voting_city']) }} as voting_city,
    {{ json_extract_scalar('_airbyte_data', ['voting_county'], ['voting_county']) }} as voting_county,
    {{ json_extract_scalar('_airbyte_data', ['party'], ['party']) }} as party,
    {{ json_extract_scalar('_airbyte_data', ['submitted_signature_to_state_api'], ['submitted_signature_to_state_api']) }} as submitted_signature_to_state_api,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['has_state_license'], ['has_state_license']) }} as has_state_license,
    {{ json_extract_scalar('_airbyte_data', ['mailing_street_address_one'], ['mailing_street_address_one']) }} as mailing_street_address_one,
    {{ json_extract_scalar('_airbyte_data', ['date_of_birth'], ['date_of_birth']) }} as date_of_birth,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['voting_street_address_two'], ['voting_street_address_two']) }} as voting_street_address_two,
    {{ json_extract_scalar('_airbyte_data', ['voting_zipcode'], ['voting_zipcode']) }} as voting_zipcode,
    {{ json_extract_scalar('_airbyte_data', ['mailing_zipcode'], ['mailing_zipcode']) }} as mailing_zipcode,
    {{ json_extract_scalar('_airbyte_data', ['name_prefix'], ['name_prefix']) }} as name_prefix,
    {{ json_extract_scalar('_airbyte_data', ['volunteer_for_rtv'], ['volunteer_for_rtv']) }} as volunteer_for_rtv,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['vr_app_status'], ['vr_app_status']) }} as vr_app_status,
    {{ json_extract_scalar('_airbyte_data', ['vr_submission_mod'], ['vr_submission_mod']) }} as vr_submission_mod,
    {{ json_extract_scalar('_airbyte_data', ['vr_submission_error'], ['vr_submission_error']) }} as vr_submission_error,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['tracking_id'], ['tracking_id']) }} as tracking_id,
    {{ json_extract_scalar('_airbyte_data', ['mailing_city'], ['mailing_city']) }} as mailing_city,
    {{ json_extract_scalar('_airbyte_data', ['submitted_via_vendor_api'], ['submitted_via_vendor_api']) }} as submitted_via_vendor_api,
    {{ json_extract_scalar('_airbyte_data', ['opt_in_sms'], ['opt_in_sms']) }} as opt_in_sms,
    {{ json_extract_scalar('_airbyte_data', ['mailing_state'], ['mailing_state']) }} as mailing_state,
    {{ json_extract_scalar('_airbyte_data', ['voting_street_address_one'], ['voting_street_address_one']) }} as voting_street_address_one,
    {{ json_extract_scalar('_airbyte_data', ['race'], ['race']) }} as race,
    {{ json_extract_scalar('_airbyte_data', ['name_suffix'], ['name_suffix']) }} as name_suffix,
    {{ json_extract_scalar('_airbyte_data', ['has_ssn'], ['has_ssn']) }} as has_ssn,
    {{ json_extract_scalar('_airbyte_data', ['opt_in_email'], ['opt_in_email']) }} as opt_in_email,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['ineligible_reason'], ['ineligible_reason']) }} as ineligible_reason,
    {{ json_extract_scalar('_airbyte_data', ['volunteer_for_partner'], ['volunteer_for_partner']) }} as volunteer_for_partner,
    {{ json_extract_scalar('_airbyte_data', ['source_id'], ['source_id']) }} as source_id,
    {{ json_extract_scalar('_airbyte_data', ['vr_app_status_details'], ['vr_app_status_details']) }} as vr_app_status_details,
    {{ json_extract_scalar('_airbyte_data', ['pre_registered'], ['pre_registered']) }} as pre_registered,
    {{ json_extract_scalar('_airbyte_data', ['opt_in_partner_email'], ['opt_in_partner_email']) }} as opt_in_partner_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_landing_page_signups') }} as table_alias
-- landing_page_signups
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


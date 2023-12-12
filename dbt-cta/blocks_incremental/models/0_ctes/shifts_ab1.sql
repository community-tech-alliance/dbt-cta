{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_shifts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['signatures_count'], ['signatures_count']) }} as signatures_count,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_id'], ['canvasser_id']) }} as canvasser_id,
    {{ json_extract_scalar('_airbyte_data', ['ready_for_delivery_at'], ['ready_for_delivery_at']) }} as ready_for_delivery_at,
    {{ json_extract_scalar('_airbyte_data', ['visual_qc_completed_by_user_id'], ['visual_qc_completed_by_user_id']) }} as visual_qc_completed_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['incomplete_vr_forms_count'], ['incomplete_vr_forms_count']) }} as incomplete_vr_forms_count,
    {{ json_extract_scalar('_airbyte_data', ['absentee_ballot_request_forms_count'], ['absentee_ballot_request_forms_count']) }} as absentee_ballot_request_forms_count,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_cards_total_collected'], ['soft_count_cards_total_collected']) }} as soft_count_cards_total_collected,
    {{ json_extract_scalar('_airbyte_data', ['phone_verification_completed_by_user_id'], ['phone_verification_completed_by_user_id']) }} as phone_verification_completed_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['field_start'], ['field_start']) }} as field_start,
    {{ json_extract_scalar('_airbyte_data', ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract_scalar('_airbyte_data', ['shift_type'], ['shift_type']) }} as shift_type,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_pre_registration_cards_collected'], ['soft_count_pre_registration_cards_collected']) }} as soft_count_pre_registration_cards_collected,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['locked_at'], ['locked_at']) }} as locked_at,
    {{ json_extract_scalar('_airbyte_data', ['locked_by_user_id'], ['locked_by_user_id']) }} as locked_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_cards_complete_collected'], ['soft_count_cards_complete_collected']) }} as soft_count_cards_complete_collected,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_cards_with_phone_collected'], ['soft_count_cards_with_phone_collected']) }} as soft_count_cards_with_phone_collected,
    {{ json_extract_scalar('_airbyte_data', ['shift_end'], ['shift_end']) }} as shift_end,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['digital'], ['digital']) }} as digital,
    {{ json_extract_scalar('_airbyte_data', ['qc_external'], ['qc_external']) }} as qc_external,
    {{ json_extract_scalar('_airbyte_data', ['ready_for_qc_at'], ['ready_for_qc_at']) }} as ready_for_qc_at,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_cards_with_incorrect_date_collected'], ['soft_count_cards_with_incorrect_date_collected']) }} as soft_count_cards_with_incorrect_date_collected,
    {{ json_extract_scalar('_airbyte_data', ['petition_pages_count'], ['petition_pages_count']) }} as petition_pages_count,
    {{ json_extract_scalar('_airbyte_data', ['ready_for_phone_verification_at'], ['ready_for_phone_verification_at']) }} as ready_for_phone_verification_at,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_cards_incomplete_collected'], ['soft_count_cards_incomplete_collected']) }} as soft_count_cards_incomplete_collected,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['staging_location_id'], ['staging_location_id']) }} as staging_location_id,
    {{ json_extract_scalar('_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['shift_start'], ['shift_start']) }} as shift_start,
    {{ json_extract_scalar('_airbyte_data', ['completed_at'], ['completed_at']) }} as completed_at,
    {{ json_extract_scalar('_airbyte_data', ['soft_count_cards_with_email_collected'], ['soft_count_cards_with_email_collected']) }} as soft_count_cards_with_email_collected,
    {{ json_extract_scalar('_airbyte_data', ['field_end'], ['field_end']) }} as field_end,
    {{ json_extract_scalar('_airbyte_data', ['incomplete_abr_forms_count'], ['incomplete_abr_forms_count']) }} as incomplete_abr_forms_count,
    {{ json_extract_scalar('_airbyte_data', ['registration_forms_count'], ['registration_forms_count']) }} as registration_forms_count,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_shifts') }} as table_alias
-- shifts
where 1 = 1


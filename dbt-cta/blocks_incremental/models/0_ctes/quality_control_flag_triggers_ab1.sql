{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_quality_control_flag_triggers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['minimum_scan_count'], ['minimum_scan_count']) }} as minimum_scan_count,
    {{ json_extract_scalar('_airbyte_data', ['phone_verification_response'], ['phone_verification_response']) }} as phone_verification_response,
    {{ json_extract_scalar('_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['stops_qc'], ['stops_qc']) }} as stops_qc,
    {{ json_extract_scalar('_airbyte_data', ['threshold_range_in_days'], ['threshold_range_in_days']) }} as threshold_range_in_days,
    {{ json_extract_scalar('_airbyte_data', ['resource_type'], ['resource_type']) }} as resource_type,
    {{ json_extract_scalar('_airbyte_data', ['threshold_requires_responses'], ['threshold_requires_responses']) }} as threshold_requires_responses,
    {{ json_extract_scalar('_airbyte_data', ['default_action_plan'], ['default_action_plan']) }} as default_action_plan,
    {{ json_extract_scalar('_airbyte_data', ['phone_verification_question_id'], ['phone_verification_question_id']) }} as phone_verification_question_id,
    {{ json_extract_scalar('_airbyte_data', ['threshold_value'], ['threshold_value']) }} as threshold_value,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_collection_threshold'], ['canvasser_collection_threshold']) }} as canvasser_collection_threshold,
    {{ json_extract_scalar('_airbyte_data', ['needs_reupload'], ['needs_reupload']) }} as needs_reupload,
    {{ json_extract_scalar('_airbyte_data', ['threshold_type'], ['threshold_type']) }} as threshold_type,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['visual_review_response_id'], ['visual_review_response_id']) }} as visual_review_response_id,
    {{ json_extract_scalar('_airbyte_data', ['implies_canvasser_issue'], ['implies_canvasser_issue']) }} as implies_canvasser_issue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_quality_control_flag_triggers') }} as table_alias
-- quality_control_flag_triggers
where 1 = 1


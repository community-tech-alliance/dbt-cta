{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_questionnaire_answers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['questionnaire_id'], ['questionnaire_id']) }} as questionnaire_id,
    {{ json_extract_scalar('_airbyte_data', ['questionnaire_code'], ['questionnaire_code']) }} as questionnaire_code,
    {{ json_extract_scalar('_airbyte_data', ['answer_value_00'], ['answer_value_00']) }} as answer_value_00,
    {{ json_extract_scalar('_airbyte_data', ['time_taken'], ['time_taken']) }} as time_taken,
    {{ json_extract_scalar('_airbyte_data', ['applicant_id'], ['applicant_id']) }} as applicant_id,
    {{ json_extract_scalar('_airbyte_data', ['answer_value_03'], ['answer_value_03']) }} as answer_value_03,
    {{ json_extract_scalar('_airbyte_data', ['answer_value_04'], ['answer_value_04']) }} as answer_value_04,
    {{ json_extract_scalar('_airbyte_data', ['job_id'], ['job_id']) }} as job_id,
    {{ json_extract_scalar('_airbyte_data', ['answer_value_01'], ['answer_value_01']) }} as answer_value_01,
    {{ json_extract_scalar('_airbyte_data', ['answer_correct_01'], ['answer_correct_01']) }} as answer_correct_01,
    {{ json_extract_scalar('_airbyte_data', ['answer_value_02'], ['answer_value_02']) }} as answer_value_02,
    {{ json_extract_scalar('_airbyte_data', ['answer_correct_00'], ['answer_correct_00']) }} as answer_correct_00,
    {{ json_extract_scalar('_airbyte_data', ['answer_correct_03'], ['answer_correct_03']) }} as answer_correct_03,
    {{ json_extract_scalar('_airbyte_data', ['answer_correct_02'], ['answer_correct_02']) }} as answer_correct_02,
    {{ json_extract_scalar('_airbyte_data', ['answer_correct_04'], ['answer_correct_04']) }} as answer_correct_04,
    {{ json_extract_scalar('_airbyte_data', ['date_taken'], ['date_taken']) }} as date_taken,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_questionnaire_answers') }} as table_alias
-- questionnaire_answers
where 1 = 1


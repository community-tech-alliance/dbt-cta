{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ctas_results_answers" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['answerId'], ['answerId']) }} as answerId,
        {{ json_extract_scalar('_airbyte_data', ['promptId'], ['promptId']) }} as promptId,
        {{ json_extract_scalar('_airbyte_data', ['resultId'], ['resultId']) }} as resultId,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        {{ json_extract_scalar('_airbyte_data', ['freeResponseAnswerText'], ['freeResponseAnswerText']) }} as freeResponseAnswerText
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'answerId',
        'promptId',
        'resultId',
        'organizationId',
        'freeResponseAnswerText'
    ]) }} as _airbyte_ctas_results_answers_hashid
from extracted

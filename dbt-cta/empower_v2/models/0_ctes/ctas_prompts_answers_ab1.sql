{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ctas_prompts_answers" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
        {{ json_extract_scalar('_airbyte_data', ['vanId'], ['vanId']) }} as vanId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['ordering'], ['ordering']) }} as int64) as ordering,
        {{ json_extract_scalar('_airbyte_data', ['promptId'], ['promptId']) }} as promptId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['isDeleted'], ['isDeleted']) }} as bool) as isDeleted,
        {{ json_extract_scalar('_airbyte_data', ['answerText'], ['answerText']) }} as answerText,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['isFreeResponse'], ['isFreeResponse']) }} as bool) as isFreeResponse,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        {{ json_extract_scalar('_airbyte_data', ['parentAnswerId'], ['parentAnswerId']) }} as parentAnswerId,
        {{ json_extract_scalar('_airbyte_data', ['defaultReplySuggestion'], ['defaultReplySuggestion']) }} as defaultReplySuggestion
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'id',
        'vanId',
        'ordering',
        'promptId',
        'isDeleted',
        'answerText',
        'isFreeResponse',
        'organizationId',
        'parentAnswerId',
        'defaultReplySuggestion'
    ]) }} as _airbyte_ctas_prompts_answers_hashid
from extracted

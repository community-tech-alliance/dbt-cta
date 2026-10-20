{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ctas_prompts" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
        {{ json_extract_scalar('_airbyte_data', ['ctaId'], ['ctaId']) }} as ctaId,
        {{ json_extract_scalar('_airbyte_data', ['vanId'], ['vanId']) }} as vanId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['ordering'], ['ordering']) }} as int64) as ordering,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['isDeleted'], ['isDeleted']) }} as bool) as isDeleted,
        {{ json_extract_scalar('_airbyte_data', ['promptText'], ['promptText']) }} as promptText,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        {{ json_extract_scalar('_airbyte_data', ['parentPromptId'], ['parentPromptId']) }} as parentPromptId,
        {{ json_extract_scalar('_airbyte_data', ['answerInputType'], ['answerInputType']) }} as answerInputType,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['usesMessageDrafts'], ['usesMessageDrafts']) }} as bool) as usesMessageDrafts,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['usesTalkingPoints'], ['usesTalkingPoints']) }} as bool) as usesTalkingPoints,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['dependsOnInitialDispositionResponse'], ['dependsOnInitialDispositionResponse']) }} as bool) as dependsOnInitialDispositionResponse
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'id',
        'ctaId',
        'vanId',
        'ordering',
        'isDeleted',
        'promptText',
        'organizationId',
        'parentPromptId',
        'answerInputType',
        'usesMessageDrafts',
        'usesTalkingPoints',
        'dependsOnInitialDispositionResponse'
    ]) }} as _airbyte_ctas_prompts_hashid
from extracted

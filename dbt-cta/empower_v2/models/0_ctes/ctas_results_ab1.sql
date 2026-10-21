{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ctas_results" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
        {{ json_extract_scalar('_airbyte_data', ['ctaId'], ['ctaId']) }} as ctaId,
        {{ json_extract_scalar('_airbyte_data', ['userEid'], ['userEid']) }} as userEid,
        {{ json_extract_scalar('_airbyte_data', ['contactEid'], ['contactEid']) }} as contactEid,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['createdMts'], ['createdMts']) }} as int64) as createdMts,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['updatedMts'], ['updatedMts']) }} as int64) as updatedMts,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['initialPromptResponse'], ['initialPromptResponse']) }} as int64) as initialPromptResponse
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'id',
        'ctaId',
        'userEid',
        'contactEid',
        'createdMts',
        'updatedMts',
        'organizationId',
        'initialPromptResponse'
    ]) }} as _airbyte_ctas_results_hashid
from extracted

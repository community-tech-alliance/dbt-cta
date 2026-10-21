{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_tags" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
        {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
        {{ json_extract_scalar('_airbyte_data', ['label'], ['label']) }} as label,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['createdMts'], ['createdMts']) }} as int64) as createdMts,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['updatedMts'], ['updatedMts']) }} as int64) as updatedMts,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'id',
        'description',
        'label',
        'createdMts',
        'updatedMts',
        'organizationId'
    ]) }} as _airbyte_tags_hashid
from extracted

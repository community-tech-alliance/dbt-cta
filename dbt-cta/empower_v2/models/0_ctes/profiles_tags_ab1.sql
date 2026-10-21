{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_profiles_tags" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['eid'], ['eid']) }} as eid,
        {{ json_extract_scalar('_airbyte_data', ['tagId'], ['tagId']) }} as tagId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['createdMts'], ['createdMts']) }} as int64) as createdMts,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        {{ json_extract_scalar('_airbyte_data', ['createdByProfileEid'], ['createdByProfileEid']) }} as createdByProfileEid
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'eid',
        'tagId',
        'createdMts',
        'organizationId',
        'createdByProfileEid'
    ]) }} as _airbyte_profiles_tags_hashid
from extracted

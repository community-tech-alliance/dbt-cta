{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_regions" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
        {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
        {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
        {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
        {{ json_extract_scalar('_airbyte_data', ['inviteCode'], ['inviteCode']) }} as inviteCode,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['inviteCodeCreatedMts'], ['inviteCodeCreatedMts']) }} as int64) as inviteCodeCreatedMts
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'id',
        'description',
        'name',
        'status',
        'inviteCode',
        'organizationId',
        'inviteCodeCreatedMts'
    ]) }} as _airbyte_regions_hashid
from extracted

{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_outreach_entries" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
        {{ json_extract_scalar('_airbyte_data', ['targetEid'], ['targetEid']) }} as targetEid,
        {{ json_extract_scalar('_airbyte_data', ['organizerEid'], ['organizerEid']) }} as organizerEid,
        {{ json_extract_scalar('_airbyte_data', ['outreachNote'], ['outreachNote']) }} as outreachNote,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['outreachCreatedMts'], ['outreachCreatedMts']) }} as int64) as outreachCreatedMts,
        {{ json_extract_scalar('_airbyte_data', ['outreachCurrentCtaId'], ['outreachCurrentCtaId']) }} as outreachCurrentCtaId
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'uuid',
        'targetEid',
        'organizerEid',
        'outreachNote',
        'organizationId',
        'outreachCreatedMts',
        'outreachCurrentCtaId'
    ]) }} as _airbyte_outreach_entries_hashid
from extracted

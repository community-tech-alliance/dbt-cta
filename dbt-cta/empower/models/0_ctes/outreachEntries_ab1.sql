{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_outreachEntries" %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract_scalar('_airbyte_data', ['outreachCurrentCtaId'], ['outreachCurrentCtaId']) }} as outreachCurrentCtaId,
    {{ json_extract('table_alias', '_airbyte_data', ['outreachEngagementLevel']) }} as outreachEngagementLevel,
    {{ json_extract_scalar('_airbyte_data', ['outreachCreatedMts'], ['outreachCreatedMts']) }} as outreachCreatedMts,
    {{ json_extract_scalar('_airbyte_data', ['outreachCtaProgress'], ['outreachCtaProgress']) }} as outreachCtaProgress,
    {{ json_extract_scalar('_airbyte_data', ['outreachSnoozeType'], ['outreachSnoozeType']) }} as outreachSnoozeType,
    {{ json_extract_scalar('_airbyte_data', ['outreachNote'], ['outreachNote']) }} as outreachNote,
    {{ json_extract('table_alias', '_airbyte_data', ['outreachScheduledFollowUpMts']) }} as outreachScheduledFollowUpMts,
    {{ json_extract_scalar('_airbyte_data', ['organizerEid'], ['organizerEid']) }} as organizerEid,
    {{ json_extract_scalar('_airbyte_data', ['outreachDidGetResponse'], ['outreachDidGetResponse']) }} as outreachDidGetResponse,
    {{ json_extract_scalar('_airbyte_data', ['outreachSnoozeUntilMts'], ['outreachSnoozeUntilMts']) }} as outreachSnoozeUntilMts,
    {{ json_extract_scalar('_airbyte_data', ['targetEid'], ['targetEid']) }} as targetEid,
    {{ json_extract_scalar('_airbyte_data', ['outreachContactMode'], ['outreachContactMode']) }} as outreachContactMode,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
where 1 = 1

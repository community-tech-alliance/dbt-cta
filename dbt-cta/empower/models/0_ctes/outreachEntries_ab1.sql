{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_empower_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('empower_partner_a', '_airbyte_raw_outreachEntries') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('empower_partner_a', '_airbyte_raw_outreachEntries') }} as table_alias
-- outreachEntries
where 1 = 1


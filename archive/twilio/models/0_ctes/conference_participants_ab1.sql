{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_conference_participants') }}
select
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['hold'], ['hold']) }} as hold,
    {{ json_extract_scalar('_airbyte_data', ['label'], ['label']) }} as label,
    {{ json_extract_scalar('_airbyte_data', ['muted'], ['muted']) }} as muted,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['call_sid'], ['call_sid']) }} as call_sid,
    {{ json_extract_scalar('_airbyte_data', ['coaching'], ['coaching']) }} as coaching,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['conference_sid'], ['conference_sid']) }} as conference_sid,
    {{ json_extract_scalar('_airbyte_data', ['call_sid_to_coach'], ['call_sid_to_coach']) }} as call_sid_to_coach,
    {{ json_extract_scalar('_airbyte_data', ['end_conference_on_exit'], ['end_conference_on_exit']) }} as end_conference_on_exit,
    {{ json_extract_scalar('_airbyte_data', ['start_conference_on_enter'], ['start_conference_on_enter']) }} as start_conference_on_enter,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_conference_participants') }}
-- conference_participants
where 1 = 1

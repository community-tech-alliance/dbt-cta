{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_conferences') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['region'], ['region']) }} as region,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['friendly_name'], ['friendly_name']) }} as friendly_name,
    {{ json_extract('table_alias', '_airbyte_data', ['subresource_uris'], ['subresource_uris']) }} as subresource_uris,
    {{ json_extract_scalar('_airbyte_data', ['reason_conference_ended'], ['reason_conference_ended']) }} as reason_conference_ended,
    {{ json_extract_scalar('_airbyte_data', ['call_sid_ending_conference'], ['call_sid_ending_conference']) }} as call_sid_ending_conference,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_conferences') }} as table_alias
-- conferences
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


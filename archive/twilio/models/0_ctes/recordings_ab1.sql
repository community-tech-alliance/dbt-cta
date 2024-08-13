{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_recordings') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['call_sid'], ['call_sid']) }} as call_sid,
    {{ json_extract_scalar('_airbyte_data', ['channels'], ['channels']) }} as channels,
    {{ json_extract_scalar('_airbyte_data', ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar('_airbyte_data', ['media_url'], ['media_url']) }} as media_url,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['price_unit'], ['price_unit']) }} as price_unit,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['conference_sid'], ['conference_sid']) }} as conference_sid,
    {{ json_extract('table_alias', '_airbyte_data', ['subresource_uris'], ['subresource_uris']) }} as subresource_uris,
    {{ json_extract('table_alias', '_airbyte_data', ['encryption_details'], ['encryption_details']) }} as encryption_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_recordings') }} as table_alias
-- recordings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


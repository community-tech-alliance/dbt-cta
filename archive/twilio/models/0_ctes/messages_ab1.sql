{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_messages') }}
select
    {{ json_extract_scalar('_airbyte_data', ['to'], ['to']) }} as {{ adapter.quote('to') }},
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['date_sent'], ['date_sent']) }} as date_sent,
    {{ json_extract_scalar('_airbyte_data', ['direction'], ['direction']) }} as direction,
    {{ json_extract_scalar('_airbyte_data', ['num_media'], ['num_media']) }} as num_media,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['price_unit'], ['price_unit']) }} as price_unit,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['num_segments'], ['num_segments']) }} as num_segments,
    {{ json_extract_scalar('_airbyte_data', ['error_message'], ['error_message']) }} as error_message,
    {{ json_extract('table_alias', '_airbyte_data', ['subresource_uris'], ['subresource_uris']) }} as subresource_uris,
    {{ json_extract_scalar('_airbyte_data', ['messaging_service_sid'], ['messaging_service_sid']) }} as messaging_service_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_messages') }} as table_alias
-- messages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


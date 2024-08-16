{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_calls') }}
select
    {{ json_extract_scalar('_airbyte_data', ['to'], ['to']) }} as {{ adapter.quote('to') }},
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['direction'], ['direction']) }} as direction,
    {{ json_extract_scalar('_airbyte_data', ['group_sid'], ['group_sid']) }} as group_sid,
    {{ json_extract_scalar('_airbyte_data', ['trunk_sid'], ['trunk_sid']) }} as trunk_sid,
    {{ json_extract_scalar('_airbyte_data', ['annotation'], ['annotation']) }} as annotation,
    {{ json_extract_scalar('_airbyte_data', ['price_unit'], ['price_unit']) }} as price_unit,
    {{ json_extract_scalar('_airbyte_data', ['queue_time'], ['queue_time']) }} as queue_time,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['answered_by'], ['answered_by']) }} as answered_by,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract_scalar('_airbyte_data', ['caller_name'], ['caller_name']) }} as caller_name,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['to_formatted'], ['to_formatted']) }} as to_formatted,
    {{ json_extract_scalar('_airbyte_data', ['forwarded_from'], ['forwarded_from']) }} as forwarded_from,
    {{ json_extract_scalar('_airbyte_data', ['from_formatted'], ['from_formatted']) }} as from_formatted,
    {{ json_extract_scalar('_airbyte_data', ['parent_call_sid'], ['parent_call_sid']) }} as parent_call_sid,
    {{ json_extract_scalar('_airbyte_data', ['phone_number_sid'], ['phone_number_sid']) }} as phone_number_sid,
    {{ json_extract('table_alias', '_airbyte_data', ['subresource_uris'], ['subresource_uris']) }} as subresource_uris,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_calls') }} as table_alias
-- calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


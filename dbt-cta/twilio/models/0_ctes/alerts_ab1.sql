{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_alerts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['log_level'], ['log_level']) }} as log_level,
    {{ json_extract_scalar('_airbyte_data', ['more_info'], ['more_info']) }} as more_info,
    {{ json_extract_scalar('_airbyte_data', ['alert_text'], ['alert_text']) }} as alert_text,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract_scalar('_airbyte_data', ['request_url'], ['request_url']) }} as request_url,
    {{ json_extract_scalar('_airbyte_data', ['service_sid'], ['service_sid']) }} as service_sid,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['resource_sid'], ['resource_sid']) }} as resource_sid,
    {{ json_extract_scalar('_airbyte_data', ['date_generated'], ['date_generated']) }} as date_generated,
    {{ json_extract_scalar('_airbyte_data', ['request_method'], ['request_method']) }} as request_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_alerts') }} as table_alias
-- alerts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


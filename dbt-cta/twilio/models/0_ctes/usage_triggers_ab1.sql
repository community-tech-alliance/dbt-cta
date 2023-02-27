{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_usage_triggers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['recurring'], ['recurring']) }} as recurring,
    {{ json_extract_scalar('_airbyte_data', ['date_fired'], ['date_fired']) }} as date_fired,
    {{ json_extract_scalar('_airbyte_data', ['trigger_by'], ['trigger_by']) }} as trigger_by,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract_scalar('_airbyte_data', ['callback_url'], ['callback_url']) }} as callback_url,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['current_value'], ['current_value']) }} as current_value,
    {{ json_extract_scalar('_airbyte_data', ['friendly_name'], ['friendly_name']) }} as friendly_name,
    {{ json_extract_scalar('_airbyte_data', ['trigger_value'], ['trigger_value']) }} as trigger_value,
    {{ json_extract_scalar('_airbyte_data', ['usage_category'], ['usage_category']) }} as usage_category,
    {{ json_extract_scalar('_airbyte_data', ['callback_method'], ['callback_method']) }} as callback_method,
    {{ json_extract_scalar('_airbyte_data', ['usage_record_uri'], ['usage_record_uri']) }} as usage_record_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_usage_triggers') }} as table_alias
-- usage_triggers
where 1 = 1


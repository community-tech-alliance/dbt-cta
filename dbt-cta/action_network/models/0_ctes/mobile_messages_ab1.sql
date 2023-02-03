{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_mobile_messages') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['media_url'], ['media_url']) }} as media_url,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['send_date'], ['send_date']) }} as send_date,
    {{ json_extract_scalar('_airbyte_data', ['timezones'], ['timezones']) }} as timezones,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['is_sending'], ['is_sending']) }} as is_sending,
    {{ json_extract_scalar('_airbyte_data', ['total_sent'], ['total_sent']) }} as total_sent,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['finish_send'], ['finish_send']) }} as finish_send,
    {{ json_extract_scalar('_airbyte_data', ['delivered_at'], ['delivered_at']) }} as delivered_at,
    {{ json_extract_scalar('_airbyte_data', ['actions_count'], ['actions_count']) }} as actions_count,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['administrative_title'], ['administrative_title']) }} as administrative_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_mobile_messages') }} as table_alias
-- mobile_messages
where 1 = 1


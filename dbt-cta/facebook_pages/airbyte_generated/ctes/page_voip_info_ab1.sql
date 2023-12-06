{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('voip_info', ['reason_code'], ['reason_code']) }} as reason_code,
    {{ json_extract_scalar('voip_info', ['is_callable'], ['is_callable']) }} as is_callable,
    {{ json_extract_scalar('voip_info', ['has_permission'], ['has_permission']) }} as has_permission,
    {{ json_extract_scalar('voip_info', ['is_callable_webrtc'], ['is_callable_webrtc']) }} as is_callable_webrtc,
    {{ json_extract_scalar('voip_info', ['is_pushable'], ['is_pushable']) }} as is_pushable,
    {{ json_extract_scalar('voip_info', ['reason_description'], ['reason_description']) }} as reason_description,
    {{ json_extract_scalar('voip_info', ['has_mobile_app'], ['has_mobile_app']) }} as has_mobile_app,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- voip_info at page/voip_info
where 1 = 1
and voip_info is not null


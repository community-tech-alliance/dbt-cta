{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_discussion_comments') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['spam'], ['spam']) }} as spam,
    {{ json_extract_scalar('_airbyte_data', ['trash'], ['trash']) }} as trash,
    {{ json_extract_scalar('_airbyte_data', ['answer'], ['answer']) }} as answer,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['forum_id'], ['forum_id']) }} as forum_id,
    {{ json_extract_scalar('_airbyte_data', ['topic_id'], ['topic_id']) }} as topic_id,
    {{ json_extract_scalar('_airbyte_data', ['published'], ['published']) }} as published,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_discussion_comments') }} as table_alias
-- discussion_comments
where 1 = 1


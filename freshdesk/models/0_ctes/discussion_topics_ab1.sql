{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_discussion_topics') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['hits'], ['hits']) }} as hits,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['locked'], ['locked']) }} as locked,
    {{ json_extract_scalar('_airbyte_data', ['sticky'], ['sticky']) }} as sticky,
    {{ json_extract_scalar('_airbyte_data', ['message'], ['message']) }} as message,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['forum_id'], ['forum_id']) }} as forum_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['replied_by'], ['replied_by']) }} as replied_by,
    {{ json_extract_scalar('_airbyte_data', ['stamp_type'], ['stamp_type']) }} as stamp_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_votes'], ['user_votes']) }} as user_votes,
    {{ json_extract_scalar('_airbyte_data', ['posts_count'], ['posts_count']) }} as posts_count,
    {{ json_extract_scalar('_airbyte_data', ['merged_topic_id'], ['merged_topic_id']) }} as merged_topic_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_discussion_topics') }} as table_alias
-- discussion_topics
where 1 = 1


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_discussion_forums') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    {{ json_extract_scalar('_airbyte_data', ['forum_type'], ['forum_type']) }} as forum_type,
    {{ json_extract_string_array('_airbyte_data', ['company_ids'], ['company_ids']) }} as company_ids,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['posts_count'], ['posts_count']) }} as posts_count,
    {{ json_extract_scalar('_airbyte_data', ['topics_count'], ['topics_count']) }} as topics_count,
    {{ json_extract_scalar('_airbyte_data', ['forum_visibility'], ['forum_visibility']) }} as forum_visibility,
    {{ json_extract_scalar('_airbyte_data', ['forum_category_id'], ['forum_category_id']) }} as forum_category_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_discussion_forums') }} as table_alias
-- discussion_forums
where 1 = 1


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_ad_creatives') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['actor_id'], ['actor_id']) }} as actor_id,
    {{ json_extract_array('_airbyte_data', ['adlabels'], ['adlabels']) }} as adlabels,
    {{ json_extract_scalar('_airbyte_data', ['link_url'], ['link_url']) }} as link_url,
    {{ json_extract_scalar('_airbyte_data', ['url_tags'], ['url_tags']) }} as url_tags,
    {{ json_extract_scalar('_airbyte_data', ['video_id'], ['video_id']) }} as video_id,
    {{ json_extract_scalar('_airbyte_data', ['image_url'], ['image_url']) }} as image_url,
    {{ json_extract_scalar('_airbyte_data', ['object_id'], ['object_id']) }} as object_id,
    {{ json_extract_scalar('_airbyte_data', ['account_id'], ['account_id']) }} as account_id,
    {{ json_extract_scalar('_airbyte_data', ['image_hash'], ['image_hash']) }} as image_hash,
    {{ json_extract_scalar('_airbyte_data', ['link_og_id'], ['link_og_id']) }} as link_og_id,
    {{ json_extract_scalar('_airbyte_data', ['object_url'], ['object_url']) }} as object_url,
    {{ json_extract('table_alias', '_airbyte_data', ['image_crops'], ['image_crops']) }} as image_crops,
    {{ json_extract_scalar('_airbyte_data', ['object_type'], ['object_type']) }} as object_type,
    {{ json_extract_scalar('_airbyte_data', ['template_url'], ['template_url']) }} as template_url,
    {{ json_extract_scalar('_airbyte_data', ['thumbnail_url'], ['thumbnail_url']) }} as thumbnail_url,
    {{ json_extract_scalar('_airbyte_data', ['product_set_id'], ['product_set_id']) }} as product_set_id,
    {{ json_extract('table_alias', '_airbyte_data', ['asset_feed_spec'], ['asset_feed_spec']) }} as asset_feed_spec,
    {{ json_extract_scalar('_airbyte_data', ['object_story_id'], ['object_story_id']) }} as object_story_id,
    {{ json_extract_scalar('_airbyte_data', ['applink_treatment'], ['applink_treatment']) }} as applink_treatment,
    {{ json_extract('table_alias', '_airbyte_data', ['object_story_spec'], ['object_story_spec']) }} as object_story_spec,
    {{ json_extract('table_alias', '_airbyte_data', ['template_url_spec'], ['template_url_spec']) }} as template_url_spec,
    {{ json_extract_scalar('_airbyte_data', ['instagram_actor_id'], ['instagram_actor_id']) }} as instagram_actor_id,
    {{ json_extract_scalar('_airbyte_data', ['instagram_story_id'], ['instagram_story_id']) }} as instagram_story_id,
    {{ json_extract_scalar('_airbyte_data', ['thumbnail_data_url'], ['thumbnail_data_url']) }} as thumbnail_data_url,
    {{ json_extract_scalar('_airbyte_data', ['call_to_action_type'], ['call_to_action_type']) }} as call_to_action_type,
    {{ json_extract_scalar('_airbyte_data', ['instagram_permalink_url'], ['instagram_permalink_url']) }} as instagram_permalink_url,
    {{ json_extract_scalar('_airbyte_data', ['effective_object_story_id'], ['effective_object_story_id']) }} as effective_object_story_id,
    {{ json_extract_scalar('_airbyte_data', ['effective_instagram_story_id'], ['effective_instagram_story_id']) }} as effective_instagram_story_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_ad_creatives') }} as table_alias
-- ad_creatives
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


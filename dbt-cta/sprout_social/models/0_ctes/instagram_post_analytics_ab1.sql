{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'instagram_post_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    created_time,
    perma_link,
    text,
    metrics,
    -- metrics fields unnested:
    {{ json_extract_scalar('metrics', ['lifetime.impressions'], ['lifetime.impressions']) }} as lifetime_impressions,
    {{ json_extract_scalar('metrics', ['lifetime.impressions_unique'], ['lifetime.impressions_unique']) }} as lifetime_impressions_unique,
    {{ json_extract_scalar('metrics', ['lifetime.likes'], ['lifetime.likes']) }} as lifetime_likes,
    {{ json_extract_scalar('metrics', ['lifetime.reactions'], ['lifetime.reactions']) }} as lifetime_reactions,
    {{ json_extract_scalar('metrics', ['lifetime.shares_count'], ['lifetime.shares_count']) }} as lifetime_shares_count,
    {{ json_extract_scalar('metrics', ['lifetime.comments_count'], ['lifetime.comments_count']) }} as lifetime_comments_count,
    {{ json_extract_scalar('metrics', ['lifetime.saves'], ['lifetime.saves']) }} as lifetime_saves,
    {{ json_extract_scalar('metrics', ['lifetime.story_taps_back'], ['lifetime.story_taps_back']) }} as lifetime_story_taps_back,
    {{ json_extract_scalar('metrics', ['lifetime.story_taps_forward'], ['lifetime.story_taps_forward']) }} as lifetime_story_taps_forward,
    {{ json_extract_scalar('metrics', ['lifetime.story_exits'], ['lifetime.story_exits']) }} as lifetime_story_exits,
    {{ json_extract_scalar('metrics', ['lifetime.video_views'], ['lifetime.video_views']) }} as lifetime_video_views,
    sent
from {{ source('cta', 'instagram_post_analytics') }}

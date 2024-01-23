{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tiktok_post_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    created_time,
    perma_link,
    text,
    metrics,
    -- metrics fields unnested:
    {{ json_extract_scalar('metrics', ['lifetime.likes'], ['lifetime.likes']) }} as lifetime_likes,
    {{ json_extract_scalar('metrics', ['lifetime.reactions'], ['lifetime.reactions']) }} as lifetime_reactions,
    {{ json_extract_scalar('metrics', ['lifetime.shares_count'], ['lifetime.shares_count']) }} as lifetime_shares_count,
    {{ json_extract_scalar('metrics', ['lifetime.comments_count'], ['lifetime.comments_count']) }} as lifetime_comments_count,
    {{ json_extract_scalar('metrics', ['lifetime.video_view_time_per_view'], ['lifetime.video_view_time_per_view']) }} as lifetime_video_view_time_per_view,
    {{ json_extract_scalar('metrics', ['lifetime.video_views_p100_per_view'], ['lifetime.video_views_p100_per_view']) }} as lifetime_video_views_p100_per_view,
    {{ json_extract_scalar('metrics', ['lifetime.impression_source_follow'], ['lifetime.impression_source_follow']) }} as lifetime_impression_source_follow,
    {{ json_extract_scalar('metrics', ['lifetime.impression_source_for_you'], ['lifetime.impression_source_for_you']) }} as lifetime_impression_source_for_you,
    {{ json_extract_scalar('metrics', ['lifetime.impression_source_hashtag'], ['lifetime.impression_source_hashtag']) }} as lifetime_impression_source_hashtag,
    {{ json_extract_scalar('metrics', ['lifetime.impression_source_personal_profile'], ['lifetime.impression_source_personal_profile']) }} as lifetime_impression_source_personal_profile,
    {{ json_extract_scalar('metrics', ['lifetime.impression_source_sound'], ['lifetime.impression_source_sound']) }} as lifetime_impression_source_sound,
    {{ json_extract_scalar('metrics', ['lifetime.impression_source_unspecified'], ['lifetime.impression_source_unspecified']) }} as lifetime_impression_source_unspecified,
    {{ json_extract_scalar('metrics', ['lifetime.video_view_time'], ['lifetime.video_view_time']) }} as lifetime_video_view_time,
    {{ json_extract_scalar('metrics', ['lifetime.video_views'], ['lifetime.video_views']) }} as lifetime_video_views,
    {{ json_extract_scalar('metrics', ['lifetime.impressions_unique'], ['lifetime.impressions_unique']) }} as lifetime_impressions_unique,
    {{ json_extract_scalar('metrics', ['lifetime.impressions'], ['lifetime.impressions']) }} as lifetime_impressions,
    {{ json_extract_scalar('metrics', ['video_length'], ['video_length']) }} as video_length,
    sent,
   {{ dbt_utils.surrogate_key([
     'created_time',
    'perma_link',
    'text',
    'sent',
    'lifetime_likes',
    'lifetime_reactions',
    'lifetime_shares_count',
    'lifetime_comments_count',
    'lifetime_video_view_time_per_view',
    'lifetime_video_views_p100_per_view',
    'lifetime_impression_source_follow',
    'lifetime_impression_source_for_you',
    'lifetime_impression_source_hashtag',
    'lifetime_impression_source_personal_profile',
    'lifetime_impression_source_sound',
    'lifetime_impression_source_unspecified',
    'lifetime_video_view_time',
    'lifetime_video_views',
    'lifetime_impressions_unique',
    'lifetime_impressions',
    'video_length'    
    ]) }} as _airbyte_tiktok_post_analytics_hashid
from {{ source('cta', 'tiktok_post_analytics') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'twitter_post_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    sent,
    text,
    metrics,
    -- metrics unnested
    {{ json_extract_scalar('metrics', ['lifetime.impressions'], ['lifetime.impressions']) }} as lifetime_impressions,
    {{ json_extract_scalar('metrics', ['lifetime.post_media_views'], ['lifetime.post_media_views']) }} as lifetime_post_media_views,
    {{ json_extract_scalar('metrics', ['lifetime.video_views'], ['lifetime.video_views']) }} as lifetime_video_views,
    {{ json_extract_scalar('metrics', ['lifetime.reactions'], ['lifetime.reactions']) }} as lifetime_reactions,
    {{ json_extract_scalar('metrics', ['lifetime.likes'], ['lifetime.likes']) }} as lifetime_likes,
    {{ json_extract_scalar('metrics', ['lifetime.comments_count'], ['lifetime.comments_count']) }} as lifetime_comments_count,
    {{ json_extract_scalar('metrics', ['lifetime.shares_count'], ['lifetime.shares_count']) }} as lifetime_shares_count,
    {{ json_extract_scalar('metrics', ['lifetime.post_content_clicks'], ['lifetime.post_content_clicks']) }} as lifetime_post_content_clicks,
    {{ json_extract_scalar('metrics', ['lifetime.post_link_clicks'], ['lifetime.post_link_clicks']) }} as lifetime_post_link_clicks,
    {{ json_extract_scalar('metrics', ['lifetime.post_content_clicks_other'], ['lifetime.post_content_clicks_other']) }} as lifetime_post_content_clicks_other,
    {{ json_extract_scalar('metrics', ['lifetime.post_media_clicks'], ['lifetime.post_media_clicks']) }} as lifetime_post_media_clicks,
    {{ json_extract_scalar('metrics', ['lifetime.post_hashtag_clicks'], ['lifetime.post_hashtag_clicks']) }} as lifetime_post_hashtag_clicks,
    {{ json_extract_scalar('metrics', ['lifetime.post_detail_expand_clicks'], ['lifetime.post_detail_expand_clicks']) }} as lifetime_post_detail_expand_clicks,
    {{ json_extract_scalar('metrics', ['lifetime.post_profile_clicks'], ['lifetime.post_profile_clicks']) }} as lifetime_post_profile_clicks,
    {{ json_extract_scalar('metrics', ['lifetime.engagements_other'], ['lifetime.engagements_other']) }} as lifetime_engagements_other,
    {{ json_extract_scalar('metrics', ['lifetime.post_followers_gained'], ['lifetime.post_followers_gained']) }} as lifetime_post_followers_gained,
    {{ json_extract_scalar('metrics', ['lifetime.post_followers_lost'], ['lifetime.post_followers_lost']) }} as lifetime_post_followers_lost,
    {{ json_extract_scalar('metrics', ['lifetime.post_app_engagements'], ['lifetime.post_app_engagements']) }} as lifetime_post_app_engagements,
    {{ json_extract_scalar('metrics', ['lifetime.post_app_installs'], ['lifetime.post_app_installs']) }} as lifetime_post_app_installs,
    {{ json_extract_scalar('metrics', ['lifetime.post_app_opens'], ['lifetime.post_app_opens']) }} as lifetime_post_app_opens,
    -- internal unnested
    json_extract_array(internal, '$.tags') as internal_tags,
    perma_link,
    created_time,
    customer_profile_id
from {{ source('cta', 'twitter_post_analytics') }}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'twitter_profile_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    metrics,
    {{ json_extract_scalar('metrics', ['comments_count'], ['comments_count']) }} as comments_count,
    {{ json_extract_scalar('metrics', ['engagements_other'], ['engagements_other']) }} as engagements,
    {{ json_extract_scalar('metrics', ['impressions'], ['impressions']) }} as impressions,
    {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_count'], ['lifetime_snapshot.followers_count']) }} as lifetime_snapshot_followers_count,
    {{ json_extract_scalar('metrics', ['likes'], ['likes']) }} as likes,
    {{ json_extract_scalar('metrics', ['net_follower_growth'], ['new_follower_growth']) }} as new_follower_growth,
    {{ json_extract_scalar('metrics', ['post_app_engagements'], ['post_app_engagements']) }} as post_app_engagements,
    {{ json_extract_scalar('metrics', ['post_app_installs'], ['post_app_installs']) }} as post_app_installs,
    {{ json_extract_scalar('metrics', ['post_app_opens'], ['post_app_opens']) }} as post_app_opens,
    {{ json_extract_scalar('metrics', ['post_content_clicks'], ['post_content_clicks']) }} as post_content_clicks,
    {{ json_extract_scalar('metrics', ['post_detail_expand_clicks'], ['post_detail_expand_clicks']) }} as post_detail_expand_clicks,
    {{ json_extract_scalar('metrics', ['post_hashtag_clicks'], ['post_hashtag_clicks']) }} as post_hashtag_clicks,
    {{ json_extract_scalar('metrics', ['post_link_clicks'], ['post_link_clicks']) }} as post_link_clicks,
    {{ json_extract_scalar('metrics', ['post_media_clicks'], ['post_media_clicks']) }} as post_media_clicks,
    {{ json_extract_scalar('metrics', ['shares_count'], ['shares_count']) }} as shares_count,
    {{ json_extract_scalar('metrics', ['video_views'], ['video_views']) }} as video_views,
    dimensions,
    -- extracted dimensions
    {{ json_extract_scalar('dimensions', ['customer_profile_id'], ['customer_profile_id']) }} as customer_profile_id,
    {{ json_extract_scalar('dimensions', ['reporting_period.by(day)'], ['reporting_period.by(day)']) }} as reporting_period_day

from {{ source('cta', 'twitter_profile_analytics') }}

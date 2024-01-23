{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tiktok_profile_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    dimensions,
    -- dimensions fields unnested:
    {{ json_extract_scalar('dimensions', ['customer_profile_id'], ['customer_profile_id']) }} as customer_profile_id,
    {{ json_extract_scalar('dimensions', ['reporting_period.by(day)'], ['reporting_period.by(day)']) }} as reporting_period_day,
    metrics,
    -- metrics fields unnested:
    {{ json_extract_scalar('metrics', ['lifetime.likes'], ['lifetime.likes']) }} as lifetime_likes,
    {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_count'], ['lifetime_snapshot.followers_count']) }} as lifetime_snapshot_followers_count,
    {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_by_country'], ['lifetime_snapshot.followers_by_country']) }} as lifetime_snapshot_followers_by_country,
    {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_by_gender'], ['lifetime_snapshot.followers_by_gender']) }} as lifetime_snapshot_followers_by_gender,
    {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_online'], ['lifetime_snapshot.followers_online']) }} as lifetime_snapshot_followers_online,
    {{ json_extract_scalar('metrics', ['net_follower_growth'], ['net_follower_growth']) }} as net_follower_growth,
    {{ json_extract_scalar('metrics', ['impressions'], ['impressions']) }} as impressions,
    {{ json_extract_scalar('metrics', ['profile_views_total'], ['profile_views_total']) }} as profile_views_total,
    {{ json_extract_scalar('metrics', ['video_views_tota'], ['video_views_tota']) }} as video_views_tota,
    {{ json_extract_scalar('metrics', ['comments_count_total'], ['comments_count_total']) }} as comments_count_total,
    {{ json_extract_scalar('metrics', ['shares_count_total'], ['shares_count_total']) }} as shares_count_total,
    {{ json_extract_scalar('metrics', ['likes_total'], ['likes_total']) }} as likes_total,
    {{ json_extract_scalar('metrics', ['posts_sent_count'], ['posts_sent_count']) }} as posts_sent_count,
    {{ json_extract_scalar('metrics', ['posts_sent_by_post_type'], ['posts_sent_by_post_type']) }} as posts_sent_by_post_type,
from {{ source('cta', 'tiktok_profile_analytics') }}
